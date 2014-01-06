mongoose = require 'mongoose'

vehicle_journeySchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  routeId: String
  calendarId: String

VehicleJourney = mongoose.model 'VehicleJourney', vehicle_journeySchema

def href = (id) -> {}
    # route
    # calendar

save = (req, res) ->
    if !req.param 'vehicle_journeys'
        res.send {"error": "bad params"}
        return
    vehicle_journey = new VehicleJourney req.body.vehicle_journeys
    vehicle_journey.save (err, vehicle_journey) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": vehicle_journey._id}

list = (req, res) ->
    VehicleJourney.find {}, (err, vehicle_journeys) ->
        res.send vehicle_journeys

show = (req, res) ->
    id = req.param 'id'
    VehicleJourney.findById id, (err, vehicle_journey) ->
        # manage 404
        res.send err if err
        res.send vehicle_journey

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
