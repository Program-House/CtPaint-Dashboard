module Update.Register exposing (update)

import Types.Register exposing (Model, Message(..))


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    model ! []
