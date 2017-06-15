module Types.Login exposing (..)


type alias Model =
    { email : String
    , password : String
    , fieldErrors : List ( Field, String )
    , responseError : Maybe String
    , showFields : Bool
    }


type Field
    = Email
    | Password


type Message
    = UpdateField Field String
    | AttemptLogin



-- INIT --


init : Model
init =
    { email = ""
    , password = ""
    , fieldErrors = []
    , responseError = Nothing
    , showFields = True
    }
