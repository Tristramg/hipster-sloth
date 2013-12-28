{expect} = require 'chai'
request = require 'supertest'
db = require './db'
Agency = require '../model/agency'
server = require '../server'
app = server.app

describe 'Agency', ->
  # call while testing db
  db()

  describe 'agency#save', ->
    it 'should post an agency', (done) ->
        request(app)
            .post('/api/agencies')
            .send(agencies:
                name: 'John'
                email: 'john@rpjs.co')
            .end (e,res) ->
                 expect(e).to.eql null
                 expect(res.body).to.exist
                 expect(res.body.id).to.exist
                 id = res.body.id

                 request(app)
                     .get('/api/agencies')
                     .end (e, res) ->
                         console.log res.body
                         expect(e).to.eql null
                         expect(res.body).to.exist
                         expect(res.body.length).to.eql 1
                         expect(res.body[0]._id).to.eql id
                         expect(res.body[0].name).to.eql 'John'
                         done()
