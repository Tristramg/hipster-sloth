mongoose = require 'mongoose'

agencySchema = new mongoose.Schema
  name: String
  created: {type: Date, default: Date.now}
  url: String
  timezone: String
  lang: String
  phone: String
  fare_url: String

module.exports = mongoose.model 'Agency', agencySchema
