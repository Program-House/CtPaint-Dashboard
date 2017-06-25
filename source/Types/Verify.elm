module Types.Verify exposing (Model(..), Message(..))


type Model
    = AttemptVerification String String
    | Success String
    | Fail String


type Message
    = VerificationSuccess String
    | VerificationFail String
