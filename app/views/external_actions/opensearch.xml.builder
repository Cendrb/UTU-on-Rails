xml.instruct!
xml.OpenSearchDescription(:xmlns => 'http://a9.com/-/spec/opensearch/1.1/', 'xmlns:moz' => 'http://www.mozilla.org/2006/browser/search/') do
  xml.ShortName('UTU')
  xml.InputEncoding('UTF-8')
  xml.Description('Co dělá ten popis?')
  xml.Contact('cendrb@gmail.com')
  xml.Image(image_url('favicon.ico'), height: 16, width: 16, type: 'image/ico')
  # escape route helper or else it escapes the '{' '}' characters. then search doesn't work
  xml.Url(type: 'text/html', method: 'get', template: CGI::unescape(search_url(query: '{searchTerms}')))
end