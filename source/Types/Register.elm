module Types.Register exposing (..)

import Http exposing (Error)
import Json.Decode as Decode
import Json.Encode as Encode
import Util exposing ((:=))


type Model
    = Registering State
    | Success String


type alias State =
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
    | RegistrationSuccess String
    | RegistrationFail String



-- INIT --


init : Model
init =
    Registering
        { username = ""
        , email = ""
        , emailConfirm = ""
        , password = ""
        , passwordConfirm = ""
        , errors = []
        , showFields = True
        , registrationPending = False
        }



-- ENCODER --


encode : State -> Encode.Value
encode { email, password, username } =
    Encode.object
        [ "email" := (Encode.string email)
        , "password" := (Encode.string password)
        , "username" := (Encode.string username)
        ]
