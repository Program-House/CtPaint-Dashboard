module Register.Init exposing (model)

import Main.Model exposing (Model, PageState(..))


model : PageState
model =
    RegisterState
        { firstEmail = ""
        , secondEmail = ""
        , firstPassword = ""
        , secondPassword = ""
        , username = ""
        , errors = []
        , showFields = True
        , registrationPending = False
        }
