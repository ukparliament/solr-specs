require 'net/http'

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

Then( 'the Prod Solr API should return an HTTP response of {string}' ) do |string|
  
  # We check the response code is 401.
  expect( @response.code ).to eq string
end

When( 'I send a request for the Test Solr API home page' ) do
  
  # We set the URL for Test Solr.
  url = 'https://api.parliament.uk/new-solr'
  
  # We get the response from Test Solr.
  @response = Net::HTTP.get_response( URI.parse( url ) )
end

Then( 'the Test Solr API should return an HTTP response of {string}' ) do |string|
  
  # We check the response code is 401.
  expect( @response.code ).to eq string
end




# ### Written to here ###




When('I send a query to the Prod Solr API with the params:') do |table|
  
  # We get the API key for Production Solr.
  api_key = ENV['API_KEY']
  
  # We extract the query string from the data table.
  query_string = table.raw[0][1]
  
  # We construct the URL for Production Solr.
  url = "https://api.parliament.uk/solr?q=#{query_string}"
  
  # We URIify the URL.
  uri = URI( url )
  
  # We construct the request ...
  request = Net::HTTP::Get.new( uri )
  
  # ... and append the API key.
  request['Ocp-Apim-Subscription-Key'] = api_key 
  
  # We get the response.
  response = Net::HTTP.start( uri.hostname, uri.port, use_ssl: uri.scheme == 'https' ) { |http|
    http.request( request )
  }
  
  puts "**********"
  puts response.code

end

Then('the HTTP response should be {int}') do |int|
# Then('the HTTP response should be {float}') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the response should have seven rows') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the reponse should contain the search term {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have typed in the query: {string}) do |string|
  pending # Write code here that turns the phrase above into concrete actions
end
