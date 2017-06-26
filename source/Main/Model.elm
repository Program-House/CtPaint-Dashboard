module Main.Model exposing (..)

import Types.Page exposing (Page(..))
import Types.Session exposing (Session)


type alias Model =
    { page : Page
    , session : Maybe Session
    }
