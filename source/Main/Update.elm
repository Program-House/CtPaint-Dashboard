module Main.Update exposing (update)

import Main.Model as Page exposing (Model)
import Main.Message exposing (Message(..))
import Update.Route as Route
import Update.Register as Register
import Update.Login as Login
import Update.Verify as Verify
import Types.Page exposing (Page(..))
import Debug exposing (log)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case ( message, model.page ) of
        ( SetRoute maybeRoute, _ ) ->
            Route.set maybeRoute model

        ( RegisterMessage subMessage, Register subModel ) ->
            let
                ( newSubModel, cmd ) =
                    Register.update subMessage subModel
            in
                { model
                    | page = Register newSubModel
                }
                    ! [ Cmd.map RegisterMessage cmd ]

        ( LoginMessage subMessage, Login subModel ) ->
            let
                ( newSubModel, cmd ) =
                    Login.update subMessage subModel
            in
                { model
                    | page = Login newSubModel
                }
                    ! [ Cmd.map LoginMessage cmd ]

        ( VerifyMessage subMessage, Verify subModel ) ->
            let
                ( newSubModel, cmd ) =
                    Verify.update subMessage subModel
            in
                { model
                    | page = Verify newSubModel
                }
                    ! [ Cmd.map VerifyMessage cmd ]

        ( LoginSuccess _, _ ) ->
            let
                _ =
                    log "Logged in" "yep"
            in
                model ! []

        ( LoginFail err, _ ) ->
            model ! []

        _ ->
            model ! []
