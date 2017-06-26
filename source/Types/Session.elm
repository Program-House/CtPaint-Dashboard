module Types.Session exposing (..)

import Json.Decode as Decode exposing (Decoder)


type alias Session =
    { username : String
    , email : String
    }



-- DECODER --


decoder : Decoder Session
decoder =
    Decode.map2
        Session
        (Decode.field "nickname" Decode.string)
        (Decode.field "email" Decode.string)
