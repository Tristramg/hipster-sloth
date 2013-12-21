require 'coffee-script'

express = require 'express'

Agency = require './model/agency'

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
    agency: Agency

exports.start = ->
    routes.setup app, handlers
    port = process.env.PORT || 3000
    app.listen port
    console.log "Express server listening on port %d in %s mode", port, app.settings.env

exports.app = app


#app = express()
#app.use express.bodyParser()
#
#$logErrors = (err, req, res, next) ->
#  console.error err.stack
#  next err
#
#errorHandler = (err, req, res, next) ->
#    res.status 500
#    res.render 'error', { error: err }
#
#
#app.get '/', (req, res) ->
#    res.send('please select a collection, e.g., /collections/messages')
#
#app.get '/:type/:id', (req, res) ->
#    type = map[req['params']['type']]
#    console.log 'Unknown type ' + req['params']['type'] unless type
#    res.send 'whoooo'
#
#app.get '/:type', (req, res) ->
#    requested_type = req['params']['type']
#    type = map[]
#    if type
#        res.send 'We got lots of ' + requested_type
#
#
#app.use express.bodyParser()
#app.use express.methodOverride()
#app.use app.router
#app.use logErrors
#app.use errorHandler

#app.get('/collections/:collectionName', function(req, res) {
#  req.collection.find({},{limit:10, sort: [['_id',-1]]}).toArray(function(e, results){
#    if (e) return next(e)
#    res.send(results)
#  })
#})
#
#app.post('/collections/:collectionName', function(req, res) {
#  req.collection.insert(req.body, {}, function(e, results){
#    if (e) return next(e)
#    res.send(results)
#  })
#})
#
#app.get('/collections/:collectionName/:id', function(req, res) {
#  req.collection.findOne({_id: req.collection.id(req.params.id)}, function(e, result){
#    if (e) return next(e)
#    res.send(result)
#  })
#})
#
#app.put('/collections/:collectionName/:id', function(req, res) {
#  req.collection.update({_id: req.collection.id(req.params.id)}, {$set:req.body}, {safe:true, multi:false}, function(e, result){
#    if (e) return next(e)
#    res.send((result===1)?{msg:'success'}:{msg:'error'})
#  })
#})
#
#app.del('/collections/:collectionName/:id', function(req, res) {
#  req.collection.remove({_id: req.collection.id(req.params.id)}, function(e, result){
#    if (e) return next(e)
#    res.send((result===1)?{msg:'success'}:{msg:'error'})
#  })
#})
#
#app.listen(3000)
#port = 3000
#app.listen port
#console.log 'Up and running port ' + port
