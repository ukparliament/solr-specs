Feature: Solr API setup
  Can we connect to the Solr APIs?

  Scenario: Checking the Prod Solr API is accessible
    Given I can connect to the web
    When I send a request for the Prod Solr API home page
    Then the API should return an HTTP response code of '401'

  Scenario: Checking the Test Solr API is accessible
    Given I can connect to the web
    When I send a request for the Test Solr API home page
    Then the API should return an HTTP response code of '401'

  Scenario: Checking the Prod Solr API is giving results
    When I send a query to the Prod Solr API with the params:
        | q     | farming   |
        | rows  | 12         |

	Then the API should return an HTTP response code of '200'
    And the response should have 12 rows
    And the response should contain the search term 'farming'

  Scenario: Checking the Test Solr API is giving results
    When I send a query to the Test Solr API with the params:
        | q     | farming   |
        | rows  | 12         |
    Then the API should return an HTTP response code of '200'
    And the response should have 12 rows
    And the response should contain the search term 'farming'
