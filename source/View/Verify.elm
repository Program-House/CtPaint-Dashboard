module View.Verify exposing (..)

import Html exposing (Html, div, p, a, br, text)
import Html.Attributes exposing (class)
import Types.Verify exposing (Model(..), Message(..))
import Types.Route exposing (Route(..))
import Route


view : Model -> Html Message
view model =
    case model of
        AttemptVerification email code ->
            container
                [ p [] [ text "Verifying.." ] ]

        Success email ->
            container
                [ p
                    []
                    [ text "Done!" ]
                , br [] []
                , p
                    []
                    [ text (email ++ " is verified.") ]
                , br [] []
                , a
                    [ Route.href Login ]
                    [ text "Log In" ]
                ]

        Fail err ->
            container
                [ p
                    []
                    [ text "Error" ]
                , br [] []
                , p
                    []
                    [ text err ]
                ]


container : List (Html Message) -> Html Message
container =
    div [ class "card solitary" ]
