module Session.Decode exposing (decode)

import Session.Model exposing (Session)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (required)


decode : Decoder Session
decode =
    Pipeline.decode Session
        |> required "userndame" Decode.string
        |> required "email" Decode.string
