module Main.Components exposing (..)

import Html exposing (node, input, text, Attribute, Html)
import Html.Attributes exposing (class, value, type_)
import Html.Events exposing (onClick)
import Main.Message exposing (Msg(..))


errorBox : List (Html Msg) -> Html Msg
errorBox children =
    node "errorbox" [] children


card : List (Attribute Msg) -> List (Html Msg) -> Html Msg
card =
    node "card"


words : String -> Html Msg
words str =
    node "words" [] [ text str ]


warning : String -> String -> Html Msg
warning class_ str =
    node "warning" [ class class_ ] [ text str ]


vectorWords : String -> Html Msg
vectorWords str =
    node "words" [ class "vector" ] [ text str ]


button : String -> Bool -> Msg -> Html Msg
button label ready msg =
    input (buttonAttributes label ready msg) []


buttonAttributes : String -> Bool -> Msg -> List (Attribute Msg)
buttonAttributes label ready msg =
    if ready then
        [ class "button"
        , onClick msg
        , type_ "submit"
        , value label
        ]
    else
        [ class "button not-ready"
        , value label
        , type_ "submit"
        ]
