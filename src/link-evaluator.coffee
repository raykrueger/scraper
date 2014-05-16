url = require "url"

STARTS_WITH_HTTP = /^http/i
SCHEME_RELATIVE = /^\/\//

###
Compare href to baseUrl and decide where the href points to.
If href is a literal url, return that. Otherwise figure out if it's scheme-relative
or path relative.

baseUrl - The url to compare against, expected: http://www.example.com/
href - The url to compare.

Returns the href if it is fully qualified, or a new fully qualified url if href
is relative.
###
resolve = (baseUrl, href) ->
  baseUri = url.parse(baseUrl)

  if STARTS_WITH_HTTP.test(href)
    uri = url.parse(href)
    uri.href

  else if SCHEME_RELATIVE.test(href)
    uri = url.parse("#{baseUri.protocol}#{href}")
    uri.href

  else #assume relative
    url.resolve(baseUrl, href)

###
Decide if the href should be followed by a scraper.

baseUrl - The base url of the website we are scraping.
href - The fully qualified url (possibly built by #resolve) to test.

Returns true if the scraper should follow the link.
###
shouldFollow = (baseUrl, href) ->
  baseUri = url.parse(baseUrl)
  uri = url.parse(href)
  baseUri.href != uri.href && baseUri.host == uri.host

module.exports = {shouldFollow: shouldFollow, resolve: resolve}
