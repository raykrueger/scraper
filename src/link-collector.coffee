_       = require 'lodash' 
request = require 'request'
cheerio = require 'cheerio'

###
  Collects links from the given url and evaluates them using the given LinkEvaluator

  url      - The fully-qualified http url to request.
  linkEval - The LinkEvaluator instance to consider links for following with.
  callback - (error, links)
             error - Any error that may have occured.
             links - An array of fully qualified urls collected from the page.

  Returns nothing specific.
###
collectLinks = (url, linkEval, callback) ->
  request url, (error, response, body) ->
    if error
      callback error, null
    else
      dom = cheerio.load(body)
      links = _.map dom("a[href != '#']"), (elem) ->
        if href = elem.attribs.href
          if linkEval.shouldFollow href
            linkEval.resolve href 
      callback null, _(links).uniq().compact().value()

module.exports = collectLinks
