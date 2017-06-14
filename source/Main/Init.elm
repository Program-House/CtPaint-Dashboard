module Main.Init exposing (init)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)


init : Value -> Location -> ( Model, Cmd Message )
init json location =
    { page = Blank
    , session = Nothing
    }
        ! []
