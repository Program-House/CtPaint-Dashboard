module Register.View exposing (view)

import Html exposing (Html, br, div, form, input)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onSubmit)
import Register.Model exposing (RegisterModel)
import Register.Message exposing (RegisterMsg(..))
import Main.Message exposing (Msg(..))
import Main.Components exposing (card, words, errorBox, warning)
import Register.Components.Fields as Fields


view : RegisterModel -> Html Msg
view model =
    card [ class "solitary register" ]
        [ words "Register new CtPaint account"
        , container
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
            , input
                [ class "button not-ready"
                , value "Register"
                , type_ "submit"
                ]
                []
                |> List.singleton
            ]
        ]


container : List (List (Html Msg)) -> Html Msg
container =
    form
        [ onSubmit (RegisterWrapper AttemptRegistration) ]
        << List.concat
