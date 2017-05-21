module Register.View exposing (view)

import Html exposing (Html, br, div, form)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onSubmit)
import Register.Model exposing (RegisterModel)
import Register.Message exposing (RegisterMsg(..))
import Main.Message exposing (Msg(..))
import Main.Components exposing (card, words, errorBox, warning)
import Register.Components.Fields as Fields
import Register.Components.RegisterButton as RegisterButton


--import Register.Components as Components
--import Register.Fields as Fields


view : RegisterModel -> Html Msg
view model =
    card [ class "solitary register" ]
        [ words "Register new CtPaint account"
        , form [ onSubmit (RegisterWrapper AttemptRegistration) ] <|
            List.concat
                [ Fields.username
                    model.username
                    model.errors
                    model.showFields
                , Fields.emails
                    model.firstEmail
                    model.secondEmail
                    model.errors
                    model.showFields
                , Fields.passwords
                    model.firstPassword
                    model.secondPassword
                    model.errors
                    model.showFields
                , model.errors
                    |> List.isEmpty
                    |> RegisterButton.view
                    |> List.singleton
                ]
        ]
