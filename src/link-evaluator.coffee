urlParser = require "url"

class LinkEvaluator
  STARTS_WITH_HTTP = /^http/i
  MAILTO = /^mailto/i
  SCHEME_RELATIVE = /^\/\//

  constructor: (base) ->
    @baseUrl = urlParser.parse base

  resolve: (href) =>
    if STARTS_WITH_HTTP.test(href)
      url = urlParser.parse(href)
      url.href

    else if SCHEME_RELATIVE.test(href)
      url = urlParser.parse("#{@baseUrl.protocol}#{href}")
      url.href

    else if MAILTO.test(href)
      null

    else #assume relative
      urlParser.resolve(@baseUrl.href, href)

  shouldFollow: (href) =>
    return false unless href
    resolvedUrl = @resolve(href)
    return false unless resolvedUrl
    url = urlParser.parse(resolvedUrl)
    @baseUrl.href != url.href && @baseUrl.host == url.host

module.exports = LinkEvaluator
