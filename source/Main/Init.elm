module Main.Init exposing (tuple)

import Main.Model exposing (Model, PageState(..))
import Main.Message exposing (Msg(..))
import Session.Model exposing (Session)
import Session.Decode as Session
import Navigation exposing (Location)
import Main.Router as Router
import Json.Decode as Decode exposing (Value)


tuple : Value -> Location -> ( Model, Cmd Msg )
tuple json location =
    Router.handle location model


model : Model
model =
    { pageState = None
    , session = Nothing
    , publicKey = Nothing
    }


getSession : Value -> Maybe Session
getSession json =
    json
        |> Decode.decodeValue Decode.string
        |> Result.toMaybe
        |> Maybe.andThen
            (Decode.decodeString Session.decode >> Result.toMaybe)
