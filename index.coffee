config = require './config'
winston = require 'winston'
mongoose = require 'mongoose'
server = require './server'

# We will log normal api operations into api.log
console.log "starting logger..."
winston.add winston.transports.File, {filename: config.logger.api}

# We will log all uncaught exceptions into exceptions.log
winston.handleExceptions new winston.transports.File {filename: config.logger.exception}
console.log "logger started. Connecting to MongoDB..."
mongoose.connect config.db.mongodb
console.log "Successfully connected to MongoDB. Starting web server..."
server.start()
console.log "Successfully started web server. Waiting for incoming connections..."
