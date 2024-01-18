Feature: Solr API expectations
  Working out what we expect the Solr API to do

  Scenario: Checking the Prod Solr API is accessible
    Given I can connect to the web
    When I send a request for the Prod Solr API home page
    Then I should get an HTTP response 200

  Scenario: Checking the Test Solr API is accessible
    Given I can connect to the web
    When I send a request for the Test Solr API home page
    Then I should get an HTTP response 200

  Scenario: Checking the Prod Solr API is giving results
    Given the Prod Solr API is running
    When I send a query to the Prod Solr API with the params:
        | q     | farming   |
        | rows  | 7         |
    Then the HTTP response should be 200
    And the response should have seven rows
    And the reponse should contain the search term "farming"

