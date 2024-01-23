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



Given('the Prod Solr API is running') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I send a query to the Prod Solr API with the params:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
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
