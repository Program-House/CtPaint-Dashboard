port module Ports exposing (..)

import Json.Encode exposing (Value)


port register : Value -> Cmd message


port registrationSuccess : (String -> message) -> Sub message


port registrationFail : (String -> message) -> Sub message


port verify : ( String, String ) -> Cmd message


port verificationSuccess : (() -> message) -> Sub message


port verificationFail : (String -> message) -> Sub message



--port toJS : String -> Cmd message
--port fromJS : (String -> message) -> Sub message
