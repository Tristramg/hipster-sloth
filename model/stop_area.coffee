mongoose = require 'mongoose'

stopAreaSchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  lon: Float
  lat: Float
  timezone: String

StopArea = mongoose.model 'StopArea', stopAreaSchema

def href = (id) -> {}
    # stop_points

save = (req, res) ->
    if !req.param 'stop_areas'
        res.send {"error": "bad params"}
        return
    stop_area = new StopArea req.body.stop_areas
    stop_area.save (err, stop_area) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": stop_area._id}

list = (req, res) ->
    StopArea.find {}, (err, stop_areas) ->
        res.send stop_areas

show = (req, res) ->
    id = req.param 'id'
    StopArea.findById id, (err, stop_area) ->
        # manage 404
        res.send err if err
        res.send stop_area

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
