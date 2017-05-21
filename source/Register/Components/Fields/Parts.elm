module Register.Components.Fields.Parts exposing (field, password, error)

import Html exposing (Html, Attribute, input, div, text, node)
import Html.Attributes exposing (class, placeholder, value, type_)
import Html.Events exposing (onInput)
import Main.Message exposing (Handler, Msg)
import Main.Components exposing (warning, errorBox)


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


password : String -> String -> String -> Bool -> Handler String -> Html Msg
password labelText placeholder_ content error handler =
    input
        [ fieldClass error
        , placeholder placeholder_
        , type_ "password"
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



--- ERROR MESSAGE


error : List String -> Html Msg
error errors =
    case errors of
        [] ->
            errorBox []

        error :: _ ->
            error
                |> warning "registration"
                |> List.singleton
                |> errorBox
