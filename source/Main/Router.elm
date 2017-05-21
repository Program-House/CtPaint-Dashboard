module Main.Router exposing (handle)

import Navigation exposing (Location)
import Main.Model exposing (Model, PageState(..))
import Register.Init
import Main.Message exposing (Msg(..))
import Main.Auth as Auth


handle : Location -> Model -> ( Model, Cmd Msg )
handle location model =
    handlePath location model


handlePath : Location -> Model -> ( Model, Cmd Msg )
handlePath location model =
    case String.split "/" location.pathname of
        [] ->
            dne model

        _ :: paths ->
            mainPaths paths model


mainPaths : List String -> Model -> ( Model, Cmd Msg )
mainPaths paths model =
    case paths of
        "" :: _ ->
            ( setState (HomeState ()) model
            , Cmd.none
            )

        "register" :: _ ->
            ( setState (Register.Init.model) model
            , Auth.getPublicKey (always Cmd.none)
            )

        head :: rest_ ->
            dne model

        _ ->
            dne model


dne : Model -> ( Model, Cmd Msg )
dne model =
    ( setState
        (ErrorState "Page does not exist")
        model
    , Cmd.none
    )


setState : PageState -> Model -> Model
setState state model =
    { model | pageState = state }
