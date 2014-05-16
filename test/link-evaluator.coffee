linkEval = require "../lib/link-evaluator"
assert   = require "assert"

describe "link-evaluator", ->
  describe "#resolve", ->

    describe "with full url", ->
      it "should return as is", ->
        url = linkEval.resolve("http://example.com", "http://example.com/test")
        assert.equal(url, "http://example.com/test")

    describe "with scheme relative url", ->
      it "should use baseUrl scheme", ->
        url = linkEval.resolve("https://example.com", "//example.com/test")
        assert.equal(url, "https://example.com/test")

    describe "with a relative href", ->
      it "should append to base", ->
        url = linkEval.resolve("http://example.com/", "/blah")
        assert.equal(url, "http://example.com/blah")


  describe "#shouldFollow", ->
    before -> @baseUrl = "http://www.example.com"

    it "should follow same host", ->
      followed = linkEval.shouldFollow(@baseUrl, "http://www.example.com/test")
      assert followed

    it "should not follow subdomain", ->
      followed = linkEval.shouldFollow(@baseUrl, "http://goats.example.com")
      assert !followed

    it "should not follow different domain", ->
      followed = linkEval.shouldFollow(@baseUrl, "http://facebook.com")
      assert !followed

    it "should not follow to baseurl", ->
      followed = linkEval.shouldFollow(@baseUrl, @baseUrl)
      assert !followed
