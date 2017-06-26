module View.Register exposing (view)

import Html exposing (Html, Attribute, p, br, div, input, text, form, a)
import Html.Attributes exposing (class, type_, value, placeholder, hidden)
import Html.Events exposing (onInput, onClick, onSubmit)
import Types.Register exposing (Model(..), State, Message(..), Field(..))


view : Model -> Html Message
view model =
    case model of
        Registering state ->
            registeringView state

        Success email ->
            successView email


successView : String -> Html Message
successView email =
    div
        [ class "card solitary register-success" ]
        [ p
            []
            [ text "Success! Your account is registered" ]
        , br [] []
        , p
            []
            [ text ("A verification email was sent to " ++ email) ]
        ]


registeringView : State -> Html Message
registeringView state =
    let
        value_ : String -> Attribute Message
        value_ =
            value << valueIfShow state.showFields

        errorView_ : Field -> Html Message
        errorView_ =
            errorView state.errors
    in
        div
            [ class "card solitary register" ]
            [ form
                [ onSubmit AttemptRegistration ]
                [ p [] [ text "Account Registration" ]
                , field
                    "Username"
                    [ value_ state.username
                    , onInput_ Username
                    ]
                , errorView_ Username
                , field
                    "Email"
                    [ value_ state.email
                    , onInput_ Email
                    ]
                , errorView_ Email
                , field
                    "Type it again"
                    [ value_ state.emailConfirm
                    , onInput_ EmailConfirm
                    ]
                , errorView_ EmailConfirm
                , field
                    "password"
                    [ value_ state.password
                    , type_ "password"
                    , onInput_ Password
                    ]
                , errorView_ Password
                , field
                    "Type it again"
                    [ value_ state.passwordConfirm
                    , type_ "password"
                    , onInput_ PasswordConfirm
                    ]
                , errorView_ PasswordConfirm
                  -- This input is here, because without it
                  -- the enter key does not cause submission
                , input
                    [ type_ "submit"
                    , hidden True
                    ]
                    []
                , a
                    [ onClick AttemptRegistration ]
                    [ text "submit" ]
                ]
            ]



-- COMPONENT HTML --


field : String -> List (Attribute Message) -> Html Message
field name attributes =
    div
        [ class "field" ]
        [ p [] [ text name ]
        , input
            attributes
            []
        ]


errorView : List ( Field, String ) -> Field -> Html Message
errorView errors fieldType =
    let
        thisFieldsErrors =
            List.filter
                (Tuple.first >> (==) fieldType)
                errors
    in
        case thisFieldsErrors of
            [] ->
                Html.text ""

            error :: _ ->
                let
                    str =
                        Tuple.second error
                in
                    div
                        [ class "error-zone" ]
                        [ p [] [ text str ] ]



-- HELPERS --


onInput_ : Field -> Attribute Message
onInput_ =
    UpdateField >> onInput


valueIfShow : Bool -> String -> String
valueIfShow show str =
    if show then
        str
    else
        "********"
