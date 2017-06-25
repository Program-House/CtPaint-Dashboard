module Types.Page exposing (Page(..))

import Types.Register as Register
import Types.Login as Login
import Types.Verify as Verify


type Page
    = Register Register.Model
    | Login Login.Model
    | Verify Verify.Model
    | Home
    | Blank
