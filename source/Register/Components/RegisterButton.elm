module Register.Components.RegisterButton exposing (view)

import Html exposing (Html, Attribute, input)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onClick)
import Main.Message exposing (Msg(..))
import Register.Message exposing (RegisterMsg(..))


view : Bool -> Html Msg
view ready =
    let
        attr =
            attributes
                "Register"
                ready
                (RegisterWrapper AttemptRegistration)
    in
        input attr []


attributes : String -> Bool -> Msg -> List (Attribute Msg)
attributes label ready msg =
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
