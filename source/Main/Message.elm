module Main.Message exposing (Msg(..), Handler)

import Navigation exposing (Location)
import Register.Message exposing (RegisterMsg(..))
import Http


type alias Handler a =
    a -> Msg


type Msg
    = UrlChange Location
    | GoHome
    | RegisterWrapper RegisterMsg
    | GetPublicKey (Result Http.Error String)
