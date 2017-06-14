module Main.View exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Page.Register as Register


view : Model -> Html Message
view model =
    div
        [ class "main" ]
        (getBody model)


getBody : Model -> List (Html Message)
getBody model =
    case model.page of
        Home ->
            [ p [] [ text "Home!" ] ]

        Register subModel ->
            List.map
                (Html.map RegisterMessage)
                (Register.view subModel)

        _ ->
            [ p [] [ text "????" ] ]
