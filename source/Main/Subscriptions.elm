module Main.Subscriptions exposing (subscriptions)

import Main.Model exposing (Model)
import Main.Message exposing (Message(..))
import Types.Page exposing (Page(..))
import Types.Register as Register
import Types.Verify as Verify
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

        Verify _ ->
            Sub.batch
                [ Ports.verificationSuccess
                    (Verify.VerificationSuccess >> VerifyMessage)
                , Ports.verificationFail
                    (Verify.VerificationFail >> VerifyMessage)
                ]

        Login _ ->
            Sub.batch
                [ Ports.loginSuccess LoginSuccess
                , Ports.loginFail LoginFail
                ]

        _ ->
            Sub.none
