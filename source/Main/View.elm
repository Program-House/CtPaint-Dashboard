module Main.View exposing (view)

import Html exposing (Html, div, p, text)
import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Page.Register as Register
import Page.Login as Login
import Page.Verify as Verify


view : Model -> Html Message
view model =
    case model.page of
        Home ->
            p [] [ text "Home!" ]

        Register subModel ->
            Html.map RegisterMessage (Register.view subModel)

        Login subModel ->
            Html.map LoginMessage (Login.view subModel)

        Verify subModel ->
            Html.map VerifyMessage (Verify.view subModel)

        _ ->
            p [] [ text "????" ]
