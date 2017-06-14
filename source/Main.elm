module Main exposing (..)

import Main.Init exposing (init)
import Main.View exposing (view)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Route
import Json.Decode as Decode exposing (Value)
import Navigation


main : Program Value Model Message
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
