require 'coffee-script'

express = require 'express'

routes = require './routes'
fs = require 'fs'
expressLogFile = fs.createWriteStream './logs/express.log', {flags: 'a'}

app = express()
# Configuration
app.configure ->
    app.use express.logger {stream: expressLogFile}
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static (__dirname + '/public')

app.configure 'development', () ->
    app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', () ->
    app.use express.errorHandler()


handlers =
    agency         : require './model/agency'
    stop_area      : require './model/stop_area'
    stop_point     : require './model/stop_point'
    line           : require './model/line'
    route          : require './model/route'
    vehicle_journey: require './model/vehicle_journey'

routes.setup app, handlers

exports.start = ->
    port = process.env.PORT || 3000
    app.listen port
    console.log "Express server listening on port %d in %s mode", port, app.settings.env

exports.app = app

