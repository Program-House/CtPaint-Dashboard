module Main.Subscriptions exposing (subscriptions)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Types.Register as Register
import Ports


subscriptions : Model -> Sub Message
subscriptions model =
    case model.page of
        Register _ ->
            Sub.batch
                [ Ports.registrationSuccess
                    (Register.RegistrationSuccess >> RegisterMessage)
                , Ports.registrationFail
                    (Register.RegistrationFail >> RegisterMessage)
                ]

        _ ->
            Sub.none
