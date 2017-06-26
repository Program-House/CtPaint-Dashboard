module Main.Init exposing (init)

import Main.Model as Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Types.Session as Session
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)
import Route exposing (fromLocation)
import Update.Route as Route


init : Value -> Location -> ( Model, Cmd Message )
init json location =
    Route.set (fromLocation location) (getModel json)


getModel : Value -> Model
getModel json =
    case Session.decodeFrom json of
        Ok val ->
            { page = Home
            , session = Just val
            }

        Err _ ->
            { page = Blank
            , session = Nothing
            }
