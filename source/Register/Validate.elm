module Register.Validate exposing (..)

import Register.Model exposing (RegisterModel, Field(..))
import Validate exposing (ifBlank, Validator)


getErrors : RegisterModel -> List ( Field, String )
getErrors =
    Validate.all
        [ .firstEmail >> ifBlank ( FirstEmail, "Please enter an email" )
        , .secondEmail >> ifBlank ( SecondEmail, "Enter email twice" )
        , .firstPassword >> ifBlank ( FirstPassword, "Please enter a password" )
        , .secondEmail >> ifBlank ( SecondPassword, "Enter password twice" )
        , .username >> ifBlank ( UserName, "Please enter a username" )
        , emailsAreTheSame
        , passwordsAreTheSame
        , passwordContainsNumber
        , passwordIsAlphanumeric
        , emailIsValid
        ]


passwordsAreTheSame : Validator ( Field, String ) RegisterModel
passwordsAreTheSame model =
    if model.firstPassword /= model.secondPassword then
        [ ( FirstPassword, "Passwords do not match" )
        , ( SecondPassword, "Passwords do not match" )
        ]
    else
        []


emailsAreTheSame : Validator ( Field, String ) RegisterModel
emailsAreTheSame model =
    if model.firstEmail /= model.secondEmail then
        [ ( SecondEmail, "Emails do not match" )
        , ( FirstEmail, "Emails do not match" )
        ]
    else
        []


passwordContainsNumber : Validator ( Field, String ) RegisterModel
passwordContainsNumber { firstPassword } =
    if firstPassword |> containsNumeric then
        []
    else
        [ ( FirstPassword, "Password must contain at least one number" ) ]


passwordIsAlphanumeric : Validator ( Field, String ) RegisterModel
passwordIsAlphanumeric { firstPassword } =
    if firstPassword |> allAlphanumeric then
        []
    else
        [ ( FirstPassword, "Password can only contain alphanumeric characters" ) ]


emailIsValid : Validator ( Field, String ) RegisterModel
emailIsValid { firstEmail } =
    let
        isValid =
            List.foldr
                ((|>) firstEmail >> (&&))
                True
                [ doesntEndWithDot
                , containsAtSign
                ]
    in
        if isValid then
            []
        else
            [ ( FirstEmail, "Email is not valid" ) ]



-- UTIL


doesntEndWithDot : String -> Bool
doesntEndWithDot =
    String.right 1 >> (/=) "."


containsAtSign : String -> Bool
containsAtSign =
    String.contains "@"


allAlphanumeric : String -> Bool
allAlphanumeric =
    String.toList >> List.foldr (isAlphanumeric >> (&&)) True


isAlphanumeric : Char -> Bool
isAlphanumeric char =
    String.contains
        (String.fromChar char)
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxwyz0123456789"


containsNumeric : String -> Bool
containsNumeric =
    String.toList >> List.foldr (isNumeric >> (||)) False


isNumeric : Char -> Bool
isNumeric char =
    String.contains
        (String.fromChar char)
        "0123456789"
