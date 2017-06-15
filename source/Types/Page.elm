module Types.Page exposing (Page(..))

import Types.Register as Register
import Types.Login as Login


type Page
    = Register Register.Model
    | Login Login.Model
    | Home
    | Blank
