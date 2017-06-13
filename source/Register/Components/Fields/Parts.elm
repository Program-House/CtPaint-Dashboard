module Register.Components.Fields.Parts exposing (field, password, error)

import Html exposing (Html, Attribute, input, div, text, node)
import Html.Attributes exposing (class, classList, placeholder, value, type_)
import Html.Events exposing (onInput)
import Main.Message exposing (Handler, Msg)
import Main.Components exposing (warning, errorBox)
import Util exposing ((:=))


field : String -> String -> String -> Bool -> Handler String -> Html Msg
field labelText placeholder_ content error handler =
    input
        [ classList
            [ "register-field" := True
            , "error" := error
            ]
        , placeholder placeholder_
        , value content
        , onInput handler
        ]
        []
        |> container labelText


password : String -> String -> String -> Bool -> Handler String -> Html Msg
password labelText placeholder_ content error handler =
    input
        [ classList
            [ "register-field" := True
            , "error" := error
            ]
        , placeholder placeholder_
        , type_ "password"
        , value content
        , onInput handler
        ]
        []
        |> container labelText


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
            errorBox [ warning "registration" error ]
