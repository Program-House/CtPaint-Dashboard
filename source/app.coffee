app = Elm.Main.fullscreen()

AmazonCognitoIdentity = require 'amazon-cognito-identity-js'
CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool
CognitoUserAttribute = AmazonCognitoIdentity.CognitoUserAttribute

poolData =
    UserPoolId: "us-east-2_xc2oQp2ju"
    ClientId: "7r81o7o9pnar49lrh54mhv0u5s"

userPool = new CognitoUserPool poolData

app.ports.register.subscribe (registration) ->
    
    attr = (name, value) ->
        payload =
            Name: name
            Value: value

        new CognitoUserAttribute payload

    dataEmail = attr "email", registration.email
    dataNickname = attr "nickname", registration.username

    attributes = [ dataEmail, dataNickname ]

    email = registration.email
    password = registration.password

    userPool.signUp email, password, attributes, null, (err, result) ->
        if err
            app.ports.registrationFail.send (String err)
        else
            app.ports.registrationSuccess.send result.user.username