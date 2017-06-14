module Page.Register exposing (view)

import Html exposing (Html, p, div, text)
import Html.Attributes exposing (class)
import Types.Register exposing (Model, Message(..))


view : Model -> Html Message
view model =
    div
        [ class "card solitary register" ]
        [ p [] [ text "Register!" ] ]
