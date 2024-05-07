require 'net/http'
require 'nokogiri'

TEST_SOLR_URL = 'https://api.parliament.uk/new-solr-test-punctuation'
PRODUCTION_SOLR_URL = 'https://api.parliament.uk/solr'


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
  url = PRODUCTION_SOLR_URL
  
  # We get the response from Production Solr.
  @response = Net::HTTP.get_response( URI.parse( url ) )
end

When( 'I send a request for the Test Solr API home page' ) do
  
  # We set the URL for Test Solr.
  url = TEST_SOLR_URL
  
  # We get the response from Test Solr.
  @response = Net::HTTP.get_response( URI.parse( url ) )
end

When('I send a query to the Prod Solr API with the params:') do |table|
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We extract the row count from the data table.
  row_count = table.raw[1][1]
  
  # We construct the URL for Production Solr.
  url = "#{PRODUCTION_SOLR_URL}?q=#{query_string}&rows=#{row_count}"
  
  # We get the response from the Solr XML.
  @response = get_response( url )
end

When('I send a query to the Test Solr API with the params:') do |table|
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We extract the row count from the data table.
  row_count = table.raw[1][1]
  
  # We construct the URL for Test Solr.
  url = "#{TEST_SOLR_URL}?q=#{query_string}&rows=#{row_count}&wt=xml"
  
  # We get the response from the Solr XML.
  @response = get_response( url )
end

When('I send a query to the Test and Production Solr APIs with the params:') do |table|
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We extract the row count from the data table.
  row_count = table.raw[1][1]
  
  # We construct the URL for Test Solr.
  test_url = "#{TEST_SOLR_URL}?q=#{query_string}&rows=#{row_count}&wt=xml"
  
  # We get the response from the Test Solr XML.
  @test_response = get_response( test_url )
  
  # We construct the URL for Production Solr.
  production_url = "#{PRODUCTION_SOLR_URL}?q=#{query_string}&rows=#{row_count}"
  
  # We get the response from the Production Solr XML.
  @production_response = get_response( production_url )
end

Then( 'the API should return an HTTP response code of {string}' ) do |string|
  
  # We check the response code.
  expect( @response.code ).to eq string
end

Then( 'the Test API should return an HTTP response code of {string}' ) do |string|
  
  # We check the response code.
  expect( @test_response.code ).to eq string
end

Then( 'the Production API should return an HTTP response code of {string}' ) do |string|
  
  # We check the response code.
  expect( @production_response.code ).to eq string
end

And( 'the response should have {int} rows' ) do |int|
  
  # We get the document count from the response XML.
  document_count = get_document_count_from_xml( @response.body )
  
  # We check the result count.
  expect( document_count ).to eq int
end

And( 'the Test response should have {int} rows' ) do |int|
  
  # We get the document count from the response XML.
  document_count = get_document_count_from_xml( @test_response.body )
  
  # We check the result count.
  expect( document_count ).to eq int
end

And( 'the Production response should have {int} rows' ) do |int|
  
  # We get the document count from the response XML.
  document_count = get_document_count_from_xml( @production_response.body )
  
  # We check the result count.
  expect( document_count ).to eq int
end

And( 'the response should contain the search term {string}' ) do |string|
  
  # We get the query string from the response XML.
  query_string = get_query_string_from_xml( @response.body )
  
  # We check the response code.
  expect( query_string ).to eq string
end

And( 'the Test response should contain the search term {string}' ) do |string|
  
  # We get the query string from the response XML.
  query_string = get_query_string_from_xml( @test_response.body )
  
  # We check the response code.
  expect( query_string ).to eq string
end

And( 'the Production response should contain the search term {string}' ) do |string|
  
  # We get the query string from the response XML.
  query_string = get_query_string_from_xml( @production_response.body )
  
  # We check the response code.
  expect( query_string ).to eq string
end

Then( 'the number of results returned by the Test response should equal the number of results returned by the Production response' ) do
  
  # We get the number of results returned by Test Solr.
  test_result_count = get_result_count_from_xml( @test_response.body )
  
  # We get the number of results returned by Production Solr.
  production_result_count = get_result_count_from_xml( @production_response.body )
  
  # We check the Test response returns the same number of results as the Production response.
  expect( test_result_count ).to eq production_result_count
end

And( 'result number {int} in the Test response should be the same as result number {int} in the Production response') do |int, int2|
  
  # We get the URI of the document at position int from Test Solr.
  test_document_uri = get_uri_of_document_at_position_from_xml( @test_response.body, int )
  
  # We get the URI of the document at position int from Production Solr.
  production_document_uri = get_uri_of_document_at_position_from_xml( @production_response.body, int )
  
  # We check the document at position X in the Test response has the same URI as the document at position Y in the Production response.
  expect( test_document_uri ).to eq production_document_uri
end

And( 'result number {int} in the Test response should have the same text snippet as result number {int} in the Production response') do |int, int2|
  
  # We get the text snippet of the document at position int from Test Solr.
  test_document_text_snippet = get_text_snippet_of_document_at_position_from_xml( @test_response.body, int )
  
  # We get the text snippet of the document at position int from Production Solr.
  production_document_text_snippet = get_text_snippet_of_document_at_position_from_xml( @production_response.body, int )
  
  # We check the document at position X in the Test response has the same text snippet as the document at position Y in the Production response.
  expect( test_document_text_snippet ).to eq production_document_text_snippet
  
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
  
  # We get the Solr response body as XML.
  doc  = Nokogiri::XML( response_body )
  
  # We get the query string.
  doc.xpath( "response/lst[@name='responseHeader']/lst[@name='params']/str[@name='q']/text()" ).to_s
end

# ## A method to get the result count from the response body of the Solr XML.
def get_result_count_from_xml( response_body )
  
  # We get the Solr response body as XML.
  doc  = Nokogiri::XML( response_body )
  
  # We get the result count.
  doc.xpath( "response/result[@name='response']/@numFound" ).first.value.to_i
end

# ## A method to get the URI of a document at a position in the response body of the Solr XML.
def get_uri_of_document_at_position_from_xml( response_body, position )
  
  # We get the Solr response body as XML.
  doc  = Nokogiri::XML( response_body )
  
  # We get the URI of the document at the specified position.
  doc.xpath( "response/result[@name='response']/doc[#{position}]/str[@name='uri']/text()" ).to_s
end

# ## A method to get the text snippet of a document at a position in the response body of the Solr XML.
def get_text_snippet_of_document_at_position_from_xml( response_body, position )
  
  # We get the Solr response body as XML.
  doc  = Nokogiri::XML( response_body )
  
  # We get the URI of the document at the specified position.
  doc.xpath( "response/result[@name='response']/doc[#{position}]/str[@name='abstract_t']/text()" ).to_s
end

