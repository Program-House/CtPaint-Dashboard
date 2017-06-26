module Types.Session exposing (..)

import Json.Decode as Decode exposing (Decoder, Value)


type alias Session =
    { username : String
    , email : String
    }



-- DECODER --


decodeFrom : Value -> Result String Session
decodeFrom =
    Decode.decodeValue decoder


decoder : Decoder Session
decoder =
    Decode.map2
        Session
        (Decode.field "nickname" Decode.string)
        (Decode.field "email" Decode.string)
