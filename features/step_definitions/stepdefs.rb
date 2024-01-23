require 'net/http'

Given( 'I can connect to the web' ) do
  
  # We use the ability to connect to Google as a proxy for the ability to connect to the web.
  url = 'https://www.google.com'
  
  # We get the response from Google.
  response = Net::HTTP.get_response( URI.parse( url ) )
  
  # We check the response code is 200.
  expect(response.code).to eq '200'
end






When('I send a request for the Prod Solr API home page') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should get an HTTP response {int}') do |int|
# Then('I should get an HTTP response {float}') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I send a request for the Test Solr API home page') do
  pending # Write code here that turns the phrase above into concrete actions
end

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
