module FridayStepHelper
  def is_it_friday(day)
    'Nope'
  end
end
World FridayStepHelper

Given("today is Sunday") do
  @today = 'Sunday'
  
end

When("I ask whether it's Friday yet") do
  @actual_answer = is_it_friday(@today)
end

Then("I should be told {string}") do |expected_answer|
  expect(@actual_answer).to eq(expected_answer)
end


Given('I can connect to the web') do
  pending # Write code here that turns the phrase above into concrete actions
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
