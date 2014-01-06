mongoose = require 'mongoose'

lineSchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  color: String

Line = mongoose.model 'Line', lineSchema

def href = (id) -> {}
    # routes

save = (req, res) ->
    if !req.param 'lines'
        res.send {"error": "bad params"}
        return
    line = new Line req.body.lines
    line.save (err, line) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": line._id}

list = (req, res) ->
    Line.find {}, (err, lines) ->
        res.send lines

show = (req, res) ->
    id = req.param 'id'
    Line.findById id, (err, line) ->
        # manage 404
        res.send err if err
        res.send line

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
