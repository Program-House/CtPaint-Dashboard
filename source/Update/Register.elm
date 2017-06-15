module Update.Register exposing (update)

import Types.Register exposing (Model, Message(..), Field(..))
import Validate exposing (ifBlank)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        UpdateField field str ->
            ( updateField field str model, Cmd.none )

        AttemptRegistration ->
            let
                errors =
                    validate model

                cmd =
                    if List.isEmpty errors then
                        Cmd.none
                    else
                        Cmd.none
            in
                { model
                    | errors = errors
                }
                    ! [ cmd ]

        _ ->
            model ! []



-- FIELDS --


updateField : Field -> String -> Model -> Model
updateField field str model =
    case field of
        Username ->
            { model | username = str }

        Email ->
            { model | email = str }

        EmailConfirm ->
            { model | emailConfirm = str }

        Password ->
            { model | password = str }

        PasswordConfirm ->
            { model | passwordConfirm = str }



-- VALIDATIONS --


validate : Model -> List ( Field, String )
validate =
    Validate.all
        [ .email >> ifBlank ( Email, "Email field is required" )
        , .password >> ifBlank ( Password, "Password field is required" )
        , .username >> ifBlank ( Username, "Username field is required" )
        , passwordsMatch
        , emailsMatch
        ]


passwordsMatch : Model -> List ( Field, String )
passwordsMatch { password, passwordConfirm } =
    if password == passwordConfirm then
        []
    else
        [ ( PasswordConfirm, "Passwords do not match" ) ]


emailsMatch : Model -> List ( Field, String )
emailsMatch { email, emailConfirm } =
    if email == emailConfirm then
        []
    else
        [ ( EmailConfirm, "Emails do not match" ) ]
