module Register.Update exposing (handle)

import Register.Message exposing (RegisterMsg(..))
import Register.Model exposing (RegisterModel)
import Main.Model exposing (Model, PageState(RegisterState))
import Main.Message exposing (Msg)
import Register.Validate exposing (getErrors)


update : RegisterMsg -> RegisterModel -> Maybe String -> ( PageState, Cmd Msg )
update message model publicKey =
    case message of
        AttemptRegistration ->
            let
                errors =
                    getErrors model
            in
                if List.isEmpty errors then
                    pack
                        { model
                            | showFields = False
                        }
                else
                    pack
                        { model
                            | errors = errors
                        }

        --pack model
        --Submit.submit cipher model
        RegistrationResult result ->
            pack model

        UpdateUserNameField str ->
            pack { model | username = str }

        UpdateFirstEmailField str ->
            pack { model | firstEmail = str }

        UpdateSecondEmailField str ->
            pack { model | secondEmail = str }

        UpdateFirstPasswordField str ->
            pack { model | firstPassword = str }

        UpdateSecondPasswordField str ->
            pack { model | secondPassword = str }


pack : RegisterModel -> ( PageState, Cmd Msg )
pack model =
    RegisterState model ! []


incorporatePageState : Model -> ( PageState, Cmd Msg ) -> ( Model, Cmd Msg )
incorporatePageState model ( pageState, cmd ) =
    ( { model | pageState = pageState }, cmd )


handle : RegisterMsg -> Model -> RegisterModel -> ( Model, Cmd Msg )
handle msg model registerModel =
    incorporatePageState
        model
        (update msg registerModel model.publicKey)
