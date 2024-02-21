require 'net/http'
require 'nokogiri'


Given( 'I can connect to the web' ) do
  
  # We use the ability to connect to Google as a proxy for the ability to connect to the web.
  url = 'https://www.google.com'
  
  # We get the response from Google.
  response = Net::HTTP.get_response( URI.parse( url ) )
  
  # We check the response code is 200.
  expect( response.code ).to eq '200'
end

When( 'I send a request for the Prod Solr API home page' ) do
  
  # We set the URL for Production Solr.
  url = 'https://api.parliament.uk/solr'
  
  # We get the response from Production Solr.
  @response = Net::HTTP.get_response( URI.parse( url ) )
end

When( 'I send a request for the Test Solr API home page' ) do
  
  # We set the URL for Test Solr.
  url = 'https://api.parliament.uk/new-solr'
  
  # We get the response from Test Solr.
  @response = Net::HTTP.get_response( URI.parse( url ) )
end

When('I send a query to the Prod Solr API with the params:') do |table|
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We extract the row count from the data table.
  row_count = table.raw[1][1]
  
  # We construct the URL for Production Solr.
  url = "https://api.parliament.uk/solr?q=#{query_string}&rows=#{row_count}"
  
  # We get the response from the Solr XML.
  @response = get_response( url )
end

When('I send a query to the Test Solr API with the params:') do |table|
  
  # We get the API key for Test Solr.
  api_key = ENV['API_KEY']
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We extract the row count from the data table.
  row_count = table.raw[1][1]
  
  # We construct the URL for Test Solr.
  url = "https://api.parliament.uk/new-solr/select?q=#{query_string}&rows=#{row_count}&wt=xml"
  
  # We get the response from the Solr XML.
  @response = get_response( url )
end

Then( 'the API should return an HTTP response code of {string}' ) do |string|
  
  # We check the response code.
  expect( @response.code ).to eq string
end

And( 'the response should have {int} rows' ) do |int|
  
  # We get the document count from the response XML.
  document_count = get_document_count_from_xml( @response.body )
  
  # We check the result count.
  expect( document_count ).to eq int
end

And( 'the response should contain the search term {string}' ) do |string|
  
  # We get the query string from the response XML.
  query_string = get_query_string_from_xml( @response.body )
  
  # We check the response code.
  expect( query_string ).to eq string
end


# A method to get the response of the Solr XML.
def get_response( url )
  
  # We get the API key for Test and Production Solr.
  api_key = ENV['API_KEY']
  
  # We URIify the URL.
  uri = URI( url )
  
  # We construct the request ...
  request = Net::HTTP::Get.new( uri )
  
  # ... and append the API key.
  request['Ocp-Apim-Subscription-Key'] = api_key
  
  # We get the response.
  Net::HTTP.start( uri.hostname, uri.port, use_ssl: uri.scheme == 'https' ) { |http|
    http.request( request )
  }
end


# ## A method to get the document count from the response body of the Solr XML.
def get_document_count_from_xml( response_body )
  
  # We get the Solr response body as XML.
  doc  = Nokogiri::XML( response_body)
  
  # We get a count of the number of doc elements returned from the XML.
  doc.xpath( '//doc' ).count
end

# ## A method to get the query string from the response body of the Solr XML.
def get_query_string_from_xml( response_body )
  
  # We get the Solr response body as XML from the XML.
  doc  = Nokogiri::XML( response_body)
  
  # We get a count of the query string.
  doc.xpath( "response/lst[@name='responseHeader']/lst[@name='params']/str[@name='q']/text()" ).to_s
end