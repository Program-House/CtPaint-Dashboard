module Types.Register exposing (..)

import Http exposing (Error)
import Json.Decode exposing (Value)


type alias Model =
    { username : String
    , email : String
    , emailConfirm : String
    , password : String
    , passwordConfirm : String
    , errors : List ( Field, String )
    , showFields : Bool
    , registrationPending : Bool
    }


type Field
    = Username
    | Email
    | EmailConfirm
    | Password
    | PasswordConfirm


type Message
    = UpdateField Field String
    | AttemptRegistration
    | RegistrationResult (Result Error Value)



-- INIT


init : Model
init =
    { username = ""
    , email = ""
    , emailConfirm = ""
    , password = ""
    , passwordConfirm = ""
    , errors = []
    , showFields = False
    , registrationPending = False
    }
