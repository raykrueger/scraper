scraper = require("../lib/scraper")
assert = require("assert")

describe "scraper", ->
  describe "#scrape", ->
    
    it "should error out", (done) ->
      scraper.scrape "Not a url", (error, body) ->
        assert error
        done()
