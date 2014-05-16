request = require "request"

scrape = (url, cb) ->
  request url, (error, response, body) ->
    cb(error, body)

module.exports.scrape = scrape
