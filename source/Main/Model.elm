module Main.Model exposing (..)

import Types.Page exposing (Page(..))
import Json.Decode as Decode exposing (Decoder)


type alias Model =
    { page : Page
    , session : Maybe Session
    }


type alias Session =
    { username : String
    , email : String
    }



-- DECODER --


decoder : Decoder Session
decoder =
    Decode.map2
        Session
        (Decode.field "username" Decode.string)
        (Decode.field "email" Decode.string)
