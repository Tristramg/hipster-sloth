mongoose = require 'mongoose'

calendarSchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  url: String
  timezone: String
  lang: String
  phone: String
  fare_url: String

Calendar = mongoose.model 'Calendar', calendarSchema

def href = (id) -> {}
    # 

save = (req, res) ->
    if !req.param 'calendars'
        res.send {"error": "bad params"}
        return
    calendar = new Calendar req.body.calendars
    calendar.save (err, calendar) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": calendar._id}

list = (req, res) ->
    Calendar.find {}, (err, calendars) ->
        res.send calendars

show = (req, res) ->
    id = req.param 'id'
    Calendar.findById id, (err, calendar) ->
        # manage 404
        res.send err if err
        res.send calendar

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
