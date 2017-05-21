module Main.Auth exposing (..)

import Main.Message exposing (Msg(..))
import Http
import Main.Api as Api


getPublicKey : Cmd Msg
getPublicKey =
    Api.root "/api/key"
        |> Http.getString
        |> Http.send GetPublicKey
