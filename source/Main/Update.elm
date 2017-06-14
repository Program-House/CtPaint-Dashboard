module Main.Update exposing (update)

import Main.Model as Page exposing (Model)
import Main.Message exposing (Message(..))
import Update.Route as Route
import Update.Register as Register
import Types.Page exposing (Page(..))


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

        _ ->
            model ! []
