collectLinks  = require '../lib/link-collector'
LinkEvaluator = require '../lib/link-evaluator'
nock          = require 'nock'
assert        = require 'assert'

describe "link-collector", ->
  describe "collectLinks", ->

    before -> 
      @baseUrl = "http://www.example.com"
      @linkEval = new LinkEvaluator(@baseUrl)
  
    # This test is a little heavy handed, but it gets the job done.  
    it "should collect links", (done) ->
      nock(@baseUrl)
        .get("/index.html")
        .reply 200, "<html><body>
                     Find this one <a href='#{@baseUrl}/findme'>blah</a>
                     And this one  <a href='#{@baseUrl}/findmetoo'>blah</a>
                     But not this one <a href='http://twitter.com/raykrueger'>blah</a>
                     </body></html>"

      collectLinks "#{@baseUrl}/index.html", @linkEval, (error, links) ->
        assert.ifError error
        assert.deepEqual links, ["http://www.example.com/findme","http://www.example.com/findmetoo"]
        done() 
