module Update.Verify exposing (update)

import Types.Verify exposing (Model(..), Message(..))
import Debug exposing (log)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        VerificationSuccess email ->
            ( Success email, Cmd.none )

        VerificationFail err ->
            ( Fail err, Cmd.none )
