port module Ports exposing (..)

import Json.Encode exposing (Value)


port register : Value -> Cmd message


port registrationSuccess : (String -> message) -> Sub message


port registrationFail : (String -> message) -> Sub message


port verify : ( String, String ) -> Cmd message


port verificationSuccess : (String -> message) -> Sub message


port verificationFail : (String -> message) -> Sub message


port login : ( String, String ) -> Cmd message


port loginSuccess : (() -> message) -> Sub message


port loginFail : (String -> message) -> Sub message
