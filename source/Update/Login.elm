module Update.Login exposing (update)

import Types.Login exposing (Model, Message(..), Field(..))
import Validate exposing (ifBlank)
import Ports


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        UpdateField field str ->
            ( updateField field str model, Cmd.none )

        AttemptLogin ->
            let
                errors =
                    validate model

                cmd =
                    if List.isEmpty errors then
                        Ports.login ( model.email, model.password )
                    else
                        Cmd.none
            in
                { model
                    | fieldErrors = errors
                }
                    ! [ cmd ]



-- FIELDS --


updateField : Field -> String -> Model -> Model
updateField field str model =
    case field of
        Email ->
            { model | email = str }

        Password ->
            { model | password = str }



-- VALIDATIONS --


validate : Model -> List ( Field, String )
validate =
    Validate.all
        [ .email >> ifBlank ( Email, "Email field is required" )
        , .password >> ifBlank ( Password, "Password field is required" )
        ]
