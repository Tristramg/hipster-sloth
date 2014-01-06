mongoose = require 'mongoose'

stopPointSchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  lon: Float
  lat: Float
  timezone: String
  stopAreaId: String

StopPoint = mongoose.model 'StopArea', stopAreaSchema

def href = (id) -> {}
    # stop_area

save = (req, res) ->
    if !req.param 'stop_points'
        res.send {"error": "bad params"}
        return
    stop_point = new StopPoint req.body.stop_areas
    stop_point.save (err, stop_area) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": stop_point._id}

list = (req, res) ->
    StopPoint.find {}, (err, stop_points) ->
        res.send stop_points

show = (req, res) ->
    id = req.param 'id'
    StopPoint.findById id, (err, stop_point) ->
        # manage 404
        res.send err if err
        res.send stop_point

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
