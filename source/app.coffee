cryptico = require "cryptico"
app = Elm.Main.fullscreen(localStorage.session or null)


app.ports.encrypt.subscribe (payload) ->
    msg = payload[0]
    plaintext = payload[1]
    publicKey = payload[2]

    { cipher, status } = cryptico.encrypt plaintext, publicKey

    if status is "success"
        encryption [ msg, cipher ]
    else
        console.log status


app.ports.storeSession.subscribe (session) ->
    localStorage.session = session


encryption = (thing) ->
    app.ports.encryption thing