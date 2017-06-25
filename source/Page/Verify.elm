module Page.Verify exposing (..)

import Html exposing (Html, div, p, br, text)
import Html.Attributes exposing (class)
import Types.Verify exposing (Model(..), Message(..))


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
