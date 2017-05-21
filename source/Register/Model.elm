module Register.Model
    exposing
        ( RegisterModel
        , Field(..)
        )


type alias RegisterModel =
    { firstEmail : String
    , secondEmail : String
    , firstPassword : String
    , secondPassword : String
    , username : String
    , errors : List ( Field, String )
    , showFields : Bool
    , registrationPending : Bool
    }


type Field
    = UserName
    | FirstEmail
    | SecondEmail
    | FirstPassword
    | SecondPassword
