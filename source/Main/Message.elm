module Main.Message exposing (Message(..), Handler)

import Types.Route exposing (Route(..))
import Types.Register as Register
import Types.Login as Login
import Types.Verify as Verify


type Message
    = SetRoute (Maybe Route)
    | RegisterMessage Register.Message
    | LoginMessage Login.Message
    | VerifyMessage Verify.Message


type alias Handler a =
    a -> Message
