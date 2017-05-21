module Main.Update exposing (update)

import Main.Model exposing (Model, PageState(..))
import Main.Message exposing (Msg(..))
import Register.Update as Register
import Main.Router as Router
import Navigation
import Main.Auth as Auth


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        UrlChange location ->
            Router.handle location model

        GoHome ->
            ( model, Navigation.newUrl "/" )

        RegisterWrapper registerMsg ->
            case model.pageState of
                RegisterState registerModel ->
                    Register.handle
                        registerMsg
                        model
                        registerModel

                _ ->
                    ( model, Cmd.none )

        GetPublicKey (Ok key) ->
            { model
                | publicKey = Just key
            }
                ! []

        GetPublicKey (Err err) ->
            { model
                | publicKey = Nothing
            }
                ! [ Auth.getPublicKey ]
