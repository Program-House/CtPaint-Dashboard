util = require "gulp-util"
cp = require "child_process"

module.exports.format = ->
    cp.exec "elm-format ./ --yes"

module.exports.make = ->
    cmd =
        [ 
            "elm-make"
            "source/Main.elm"
            "--warn"
            "--output"
            "development/elm.js"
        ].join " "

    cp.exec cmd, handleStdOut


handleStdOut = (error, stdout, stderr) ->
    if error
        errorStr = String error

        error = errorStr.slice 0, errorStr.length - 1

        (error.split "\n").forEach (line) ->
            util.log (util.colors.red (String line))

    else
        stderr = stderr.slice 0, stderr.length - 1

        (stderr.split "\n").forEach (line) ->
            util.log (util.colors.yellow (String line))

    stdout = stdout.slice 0, stdout.length - 1

    (stdout.split "\n").forEach (line) ->
        util.log (util.colors.cyan "Elm"), line
