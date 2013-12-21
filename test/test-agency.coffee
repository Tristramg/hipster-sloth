{expect} = require 'chai'
db = require './db'
Agency = require '../model/agency'

describe 'Agency', ->
  # call while testing db
  db()

  describe '#save', ->

    it 'should save agency', (done) ->
      data = {name: 'Fake agency'}
      user = new Agency data
      user.save (err, user) ->
        done err if err
        expect(user.email).to.equal data.email
        expect(user.created).to.exist
        expect(user._id).to.exist
        done()
