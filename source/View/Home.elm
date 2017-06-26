module View.Home exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Main.Message exposing (Message(..))
import Types.Session exposing (Session)


view : Session -> Html Message
view session =
    div
        [ class "main" ]
        [ p [] [ text session.email ] ]
