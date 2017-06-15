module Page.Login exposing (view)

import Html exposing (Html, Attribute, p, div, input, text, form, a)
import Html.Attributes exposing (class, type_, value, placeholder, hidden)
import Html.Events exposing (onInput, onClick, onSubmit)
import Types.Login exposing (Model, Message(..), Field(..))


view : Model -> Html Message
view model =
    let
        value_ : String -> Attribute Message
        value_ =
            value << valueIfShow model.showFields

        errorView_ : Field -> Html Message
        errorView_ =
            errorView model.fieldErrors
    in
        div
            [ class "card solitary" ]
            [ form
                [ onSubmit AttemptLogin ]
                [ field
                    "Email"
                    [ value_ model.email
                    , onInput_ Email
                    ]
                , errorView_ Email
                , field
                    "Password"
                    [ value_ model.password
                    , onInput_ Password
                    ]
                  -- This input is here, because without it
                  -- the enter key does not cause submission
                , input
                    [ type_ "submit"
                    , hidden True
                    ]
                    []
                , a
                    [ onClick AttemptLogin ]
                    [ text "Log in" ]
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
