module Main.Init exposing (tuple)

import Main.Model exposing (..)
import Main.Message exposing (Msg(..))
import Navigation exposing (Location)
import Main.Router as Router
import Json.Decode exposing (Value)


tuple : Value -> Location -> ( Model, Cmd Msg )
tuple json location =
    Router.handle location model


model : Model
model =
    { pageState = None
    , user = Nothing
    , publicKey = Nothing
    }
