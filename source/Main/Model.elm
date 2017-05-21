module Main.Model exposing (..)

import Register.Model exposing (RegisterModel)
import Home.Model exposing (HomeModel)
import Session.Model exposing (Session)


type alias Model =
    { pageState : PageState
    , session : Maybe Session
    , publicKey : Maybe String
    }


type PageState
    = RegisterState RegisterModel
    | SuccessfulRegisterState String
    | HomeState HomeModel
    | ErrorState String
    | None
