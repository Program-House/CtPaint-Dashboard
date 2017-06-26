AmazonCognitoIdentity = require 'amazon-cognito-identity-js'
CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool

poolData =
    UserPoolId: "us-east-2_xc2oQp2ju"
    ClientId: "7r81o7o9pnar49lrh54mhv0u5s"

userPool = new CognitoUserPool poolData

register = require "./Aws/register"
verify = require "./Aws/verify"
login = require "./Aws/login"
init = require "./Aws/init"

init userPool

app = Elm.Main.fullscreen()

app.ports.register.subscribe (register app, userPool)
app.ports.verify.subscribe (verify app, userPool)
app.ports.login.subscribe (login app, userPool)







