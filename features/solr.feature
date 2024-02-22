Feature: Solr API expectations
  Working out what we expect the Solr API to do

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
	
  Scenario: Checking the Test and Production Solr APIs are returning the same number of results
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | farming   |
      | rows  | 12         |
    Then the Test API should return an HTTP response code of '200'
    And the Production API should return an HTTP response code of '200'
    And the Test response should have 12 rows
	And the Production response should have 12 rows
    And the Test response should contain the search term 'farming'
	And the Production response should contain the search term 'farming'
	And the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 5 in the Test response should be the same as result number 5 in the Production response

