Feature: Solr API expectations
  Working out what we expect the Solr API to do

  Scenario: Checking the Prod Solr API is accessible
    Given I can connect to the web
    When I send a request for the Prod Solr API home page
    Then I should get an HTTP response 200
