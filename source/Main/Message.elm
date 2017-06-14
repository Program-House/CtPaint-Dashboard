module Main.Message exposing (Message(..), Handler)

import Types.Route exposing (Route(..))
import Types.Register as Register


type Message
    = SetRoute (Maybe Route)
    | RegisterMessage Register.Message


type alias Handler a =
    a -> Message
