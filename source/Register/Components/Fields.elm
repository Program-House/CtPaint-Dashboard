module Register.Components.Fields exposing (..)

import Html exposing (Html)
import Main.Message exposing (Msg(..))
import Register.Model exposing (Field(..))
import Register.Message exposing (RegisterMsg(..))
import Register.Components.Fields.Prototype exposing (field)
import Main.Components exposing (errorBox)


username : String -> List ( Field, String ) -> Bool -> List (Html Msg)
username str errors showField =
    let
        content =
            if showField then
                str
            else
                "********"
    in
        [ field
            "username"
            "username"
            content
            (not <| List.isEmpty errors)
            (RegisterWrapper << UpdateUserNameField)
          --, errorBox List.head
        ]
