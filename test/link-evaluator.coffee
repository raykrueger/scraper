LinkEvaluator = require "../lib/link-evaluator"
assert   = require "assert"

describe "link-evaluator", ->

  before -> @linkEval = new LinkEvaluator("http://example.com")

  describe "#resolve", ->

    describe "with full url", ->
      it "should return as is", ->
        url = @linkEval.resolve("http://example.com/test")
        assert.equal(url, "http://example.com/test")

    describe "with scheme relative url", ->
      it "should use baseUrl scheme", ->
        url = @linkEval.resolve("//example.com/test")
        assert.equal(url, "http://example.com/test")

    describe "with a relative href", ->
      it "should append to base", ->
        url = @linkEval.resolve("/blah")
        assert.equal(url, "http://example.com/blah")


  describe "#shouldFollow", ->

    it "should follow same host", ->
      followed = @linkEval.shouldFollow("test")
      assert followed

    it "should follow scheme relative hrefs", ->
      followed = @linkEval.shouldFollow("//example.com/test")
      assert followed

    it "should not follow subdomain", ->
      followed = @linkEval.shouldFollow("http://goats.example.com")
      assert !followed

    it "should not follow different domain", ->
      followed = @linkEval.shouldFollow("http://facebook.com")
      assert !followed

    it "should not follow to baseurl", ->
      followed = @linkEval.shouldFollow("http://example.com")
      assert !followed

    it "should not follow mailto links", ->
      followed = @linkEval.shouldFollow("mailto:nope@example.com")
      assert !followed
