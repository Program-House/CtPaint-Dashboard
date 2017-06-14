module Main.Model exposing (..)

import Types.Page exposing (Page(..))


type alias Model =
    { page : Page
    , session : Maybe Session
    }


type alias Session =
    { username : String
    , email : String
    , token : String
    }
