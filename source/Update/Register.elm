module Update.Register exposing (update)

import Types.Register as Register exposing (Model(..), State, Message(..), Field(..))
import Validate exposing (ifBlank)
import Ports


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case model of
        Registering state ->
            updateState message state

        _ ->
            model ! []


updateState : Message -> State -> ( Model, Cmd Message )
updateState message state =
    case message of
        UpdateField field str ->
            ( Registering (updateField field str state)
            , Cmd.none
            )

        AttemptRegistration ->
            let
                errors =
                    validate state
            in
                if List.isEmpty errors then
                    let
                        newState =
                            { state
                                | errors = errors
                                , password = ""
                                , passwordConfirm = ""
                                , showFields = False
                            }
                    in
                        (Registering newState)
                            ! [ Ports.register (Register.encode state) ]
                else
                    let
                        newState =
                            { state
                                | errors = errors
                                , password = ""
                                , passwordConfirm = ""
                            }
                    in
                        (Registering newState) ! []

        RegistrationSuccess email ->
            (Success email) ! []

        RegistrationFail fail ->
            ( Registering (handleFail fail state)
            , Cmd.none
            )


handleFail : String -> State -> State
handleFail fail state =
    case fail of
        "UsernameExistsException: User already exists" ->
            { state
                | errors =
                    ( Email
                    , "Email is already registered to an account"
                    )
                        |> List.singleton
            }

        other ->
            { state
                | errors =
                    [ ( Email, other ) ]
            }



-- FIELDS --


updateField : Field -> String -> State -> State
updateField field str state =
    case field of
        Username ->
            { state | username = str }

        Email ->
            { state | email = str }

        EmailConfirm ->
            { state | emailConfirm = str }

        Password ->
            { state | password = str }

        PasswordConfirm ->
            { state | passwordConfirm = str }



-- VALIDATIONS --


validate : State -> List ( Field, String )
validate =
    Validate.all
        [ .email >> ifBlank ( Email, "Email field is required" )
        , .password >> ifBlank ( Password, "Password field is required" )
        , .username >> ifBlank ( Username, "Username field is required" )
        , passwordsMatch
        , passwordLongEnough
        , emailsMatch
        , atLeastOneUpperCaseInPassword
        , atLeastOneLowerCaseInPassword
        , validEmail
        ]


validEmail : State -> List ( Field, String )
validEmail model =
    case String.split "@" model.email of
        "" :: _ ->
            invalidEmail

        local :: rest ->
            case rest of
                [ domain ] ->
                    separateDomain domain local

                _ ->
                    invalidEmail

        _ ->
            invalidEmail


separateDomain : String -> String -> List ( Field, String )
separateDomain domain local =
    case String.split "." domain of
        _ :: [ "" ] ->
            invalidEmail

        name :: [ extension ] ->
            let
                allAlphanumeric =
                    List.foldr
                        (onlyAlphaNumeric >> (&&))
                        True
                        [ local, name, extension ]
            in
                if allAlphanumeric then
                    []
                else
                    invalidEmail

        _ ->
            invalidEmail


invalidEmail : List ( Field, String )
invalidEmail =
    [ ( Email, "Please enter a valid email address" ) ]


onlyAlphaNumeric : String -> Bool
onlyAlphaNumeric =
    String.all isAlphanumeric


isAlphanumeric : Char -> Bool
isAlphanumeric char =
    String.contains (String.fromChar char) alphanumeric


alphanumeric : String
alphanumeric =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"


atLeastOneLowerCaseInPassword : State -> List ( Field, String )
atLeastOneLowerCaseInPassword { password } =
    if password == String.toUpper password then
        [ ( Password, "Password must contain at least one lower case letter" ) ]
    else
        []


atLeastOneUpperCaseInPassword : State -> List ( Field, String )
atLeastOneUpperCaseInPassword { password } =
    if password == String.toLower password then
        [ ( Password, "Password must contain at least one upper case letter" ) ]
    else
        []


passwordLongEnough : State -> List ( Field, String )
passwordLongEnough { password } =
    if String.length password < 8 then
        [ ( Password, "Password must be at least 8 characters" ) ]
    else
        []


passwordsMatch : State -> List ( Field, String )
passwordsMatch { password, passwordConfirm } =
    if password == passwordConfirm then
        []
    else
        [ ( PasswordConfirm, "Passwords do not match" ) ]


emailsMatch : State -> List ( Field, String )
emailsMatch { email, emailConfirm } =
    if email == emailConfirm then
        []
    else
        [ ( EmailConfirm, "Emails do not match" ) ]
