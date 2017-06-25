module Route exposing (..)

import UrlParser as Url exposing (parseHash, s, (</>), string, oneOf, Parser)
import Navigation exposing (Location)
import Html.Attributes as Attributes
import Html exposing (Attribute)
import Types.Route as Route exposing (Route(..))
import Debug exposing (log)


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Route.Home (s "")
        , Url.map Route.Login (s "login")
        , Url.map Route.Logout (s "logout")
        , Url.map Route.Register (s "register")
        , Url.map Route.Verify (s "verify" </> string </> string)
        ]



-- INTERNAL --


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Route.Home ->
                    []

                Route.Login ->
                    [ "login" ]

                Route.Logout ->
                    [ "logout" ]

                Route.Register ->
                    [ "register" ]

                Route.Verify email code ->
                    [ "verify", log "email" email, code ]
    in
        "#/" ++ (String.join "/" pieces)



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attributes.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
