module Register.Message exposing (RegisterMsg(..))

import Http
import Json.Decode as Json


type RegisterMsg
    = AttemptRegistration
    | RegistrationResult (Result Http.Error Json.Value)
    | UpdateUserNameField String
    | UpdateFirstEmailField String
    | UpdateSecondEmailField String
    | UpdateFirstPasswordField String
    | UpdateSecondPasswordField String
