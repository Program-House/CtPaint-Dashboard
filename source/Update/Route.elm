module Update.Route exposing (..)

import Types.Route as Route exposing (Route)
import Types.Page as Page
import Types.Register as Register
import Types.Login as Login
import Types.Verify as Verify
import Main.Message exposing (Message(..))
import Main.Model exposing (Model)
import Ports


set : Maybe Route -> Model -> ( Model, Cmd Message )
set maybeRoute model =
    case maybeRoute of
        Nothing ->
            { model | page = Page.Blank } ! []

        Just (Route.Home) ->
            { model | page = Page.Home } ! []

        Just (Route.Login) ->
            { model
                | page = Page.Login Login.init
            }
                ! []

        Just (Route.Logout) ->
            model ! []

        Just (Route.Register) ->
            { model
                | page = Page.Register Register.init
            }
                ! []

        Just (Route.Verify email code) ->
            { model
                | page =
                    Verify.AttemptVerification email code
                        |> Page.Verify
            }
                ! [ Ports.verify ( email, code ) ]
