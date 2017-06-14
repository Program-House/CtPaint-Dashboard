module Types.Page exposing (Page(..))

import Types.Register as Register


type Page
    = Register Register.Model
    | Login
    | Home
    | Blank
