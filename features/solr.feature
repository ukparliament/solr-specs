Feature: Solr API expectations
  Working out what we expect the Solr API to do

  Scenario: Checking the Prod Solr API is accessible
    Given I can connect to the web
    When I send a request for the Prod Solr API home page
    Then the Prod Solr API should return an HTTP response of '401'

  Scenario: Checking the Test Solr API is accessible
    Given I can connect to the web
    When I send a request for the Test Solr API home page
    Then the Test Solr API should return an HTTP response of '401'

  Scenario: Checking the Prod Solr API is giving results
    When I send a query to the Prod Solr API with the params:
        | q     | farming   |
        | rows  | 7         |
    Then the HTTP response should be 200
    And the response should have seven rows
    And the response should contain the search term "farming"

Feature: Query resultset expectations
  Comparing resultsets from each Solr API

  Scenario: Comparing results for the query: "minister's" session:21/22
    Given I have types in the query: "minister's" session:21/22
    When the Solr query is: minister's AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T23:59:59Z])
    Then the number of results from the Test API should be 246
    And the number of results from the Prod API should be 43791
