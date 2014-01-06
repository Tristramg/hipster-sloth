mongoose = require 'mongoose'

routeSchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}

Route = mongoose.model 'Route', routeSchema

def href = (id) -> {}
    # line

save = (req, res) ->
    if !req.param 'routes'
        res.send {"error": "bad params"}
        return
    route = new Route req.body.routes
    route.save (err, route) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": route._id}

list = (req, res) ->
    Route.find {}, (err, routes) ->
        res.send routes

show = (req, res) ->
    id = req.param 'id'
    Route.findById id, (err, route) ->
        # manage 404
        res.send err if err
        res.send route

update = (req, res) ->
    id = req.param 'id'
    # manage 404
    # delete

delete = (req, res) ->
    id = req.param 'id'
    # manage 404
    # delete

module.exports =
    save: save
    list: list
    show: show
    update: update
    delete: delete
