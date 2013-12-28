mongoose = require 'mongoose'

agencySchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  url: String
  timezone: String
  lang: String
  phone: String
  fare_url: String

Agency = mongoose.model 'Agency', agencySchema

def href = (id) -> {}
    # 

save = (req, res) ->
    if !req.param 'agencies'
        res.send {"error": "bad params"}
        return
    agency = new Agency req.body.agencies
    agency.save (err, agency) ->
        if err
            res.send {"error": err}
            return
        else
            res.send {"id": agency._id}

list = (req, res) ->
    Agency.find {}, (err, agencies) ->
        res.send agencies

show = (req, res) ->
    id = req.param 'id'
    Agency.findById id, (err, agency) ->
        # manage 404
        res.send err if err
        res.send agency

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
