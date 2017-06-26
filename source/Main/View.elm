module Main.View exposing (view)

import Html exposing (Html, div, p, text)
import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import View.Register as Register
import View.Login as Login
import View.Verify as Verify


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
