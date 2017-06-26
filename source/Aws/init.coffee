AmazonCognitoIdentity = require 'amazon-cognito-identity-js'

module.exports = (userPool) ->
    user = userPool.getCurrentUser()

    if user isnt null 
        user.getSession (err, session) ->
            if err
                console.log err
                return

            user.getUserAttributes (err, attributes) ->
                if err
                    console.log "B", err
                else
                    console.log "Attributes!", attributes