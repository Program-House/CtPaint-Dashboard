module Main exposing (..)

import Navigation
import Main.Message exposing (..)
import Main.Model exposing (..)
import Main.View exposing (view)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Main.Init as Init


main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
        { init = Init.tuple
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
