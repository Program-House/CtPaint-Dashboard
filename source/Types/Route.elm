module Types.Route exposing (Route(..))


type Route
    = Register
    | Login
    | Logout
    | Home
    | Verify String String
