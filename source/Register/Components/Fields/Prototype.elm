module Register.Components.Fields.Prototype exposing (field)

import Html exposing (Html, Attribute, input, div, text, node)
import Html.Attributes exposing (class, placeholder, value, type_)
import Html.Events exposing (onInput)
import Main.Message exposing (Handler, Msg)


field : String -> String -> String -> Bool -> Handler String -> Html Msg
field labelText placeholder_ content error handler =
    input
        [ fieldClass error
        , placeholder placeholder_
        , value content
        , onInput handler
        ]
        []
        |> container labelText


fieldClass : Bool -> Attribute Msg
fieldClass error =
    if error then
        class "register-field error"
    else
        class "register-field"


container : String -> Html Msg -> Html Msg
container labelText input_ =
    div
        [ class "register-field-container" ]
        [ label labelText
        , input_
        ]


label : String -> Html Msg
label str =
    node "fieldlabel" [] [ text str ]
