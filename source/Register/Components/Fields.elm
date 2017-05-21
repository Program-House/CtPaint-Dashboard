module Register.Components.Fields exposing (..)

import Html exposing (Html)
import Main.Message exposing (Msg(..))
import Register.Model exposing (Field(..))
import Register.Message exposing (RegisterMsg(..))
import Register.Components.Fields.Parts as Parts


username : String -> List ( Field, String ) -> Bool -> List (Html Msg)
username content errors showFields =
    let
        thisFieldsErrors =
            getThisFieldsErrors UserName errors
    in
        [ Parts.field
            "username"
            "username"
            (determineContent showFields content)
            (isntEmpty thisFieldsErrors)
            (toMsg UpdateUserNameField)
        , Parts.error thisFieldsErrors
        ]


emails : String -> String -> List ( Field, String ) -> Bool -> List (Html Msg)
emails firstEmail secondEmail errors showFields =
    let
        firstEmailErrors =
            getThisFieldsErrors FirstEmail errors

        secondEmailErrors =
            getThisFieldsErrors SecondEmail errors
    in
        [ Parts.field
            "email"
            "your email"
            (determineContent showFields firstEmail)
            (isntEmpty firstEmailErrors)
            (toMsg UpdateFirstEmailField)
        , Parts.field
            "email"
            "your email again"
            (determineContent showFields secondEmail)
            (isntEmpty secondEmailErrors)
            (toMsg UpdateSecondEmailField)
        , Parts.error (List.append firstEmailErrors secondEmailErrors)
        ]


passwords : String -> String -> List ( Field, String ) -> Bool -> List (Html Msg)
passwords firstPassword secondPassword errors showFields =
    let
        firstPasswordErrors =
            getThisFieldsErrors FirstPassword errors

        secondPasswordErrors =
            getThisFieldsErrors SecondPassword errors
    in
        [ Parts.password
            "password"
            "enter a password"
            (determineContent showFields firstPassword)
            (isntEmpty firstPasswordErrors)
            (toMsg UpdateFirstPasswordField)
        , Parts.password
            "password"
            "enter it again"
            (determineContent showFields secondPassword)
            (isntEmpty secondPasswordErrors)
            (toMsg UpdateSecondPasswordField)
        , Parts.error (List.append firstPasswordErrors secondPasswordErrors)
        ]



-- UTIL


toMsg : (a -> RegisterMsg) -> (a -> Msg)
toMsg registerMsg =
    registerMsg >> RegisterWrapper


determineContent : Bool -> String -> String
determineContent show content =
    if show then
        content
    else
        "********"


getThisFieldsErrors : Field -> List ( Field, String ) -> List String
getThisFieldsErrors field errors =
    errors
        |> List.filter (Tuple.first >> (==) field)
        |> List.map Tuple.second


isntEmpty : List a -> Bool
isntEmpty =
    List.isEmpty >> not
