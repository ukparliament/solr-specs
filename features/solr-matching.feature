Feature: Solr API matching
  Exploring the differences between Test and Production Solr APIs
  # All scenarios take a query and test three things:
  # * whether the same number of results are returned
  # * whether the results are returned in the same order
  # * whether a given result returns the same text snippet

  
  Scenario: for the query farming
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | farming   |
      | rows  | 20         |
	Then the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 5 in the Test response should be the same as result number 5 in the Production response
 	And result number 5 in the Test response should have the same text snippet as result number 5 in the Production response

  Scenario: for the query type:edm date:01/03/2022
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | type_sesrollup:90996^0 AND date_dt:[2022-03-01T00:00:00.000Z TO 2022-03-01T23:59:59.999Z]   |
      | rows  | 20         |
	Then the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 3 in the Test response should be the same as result number 3 in the Production response
 	And result number 3 in the Test response should have the same text snippet as result number 3 in the Production response
	
  Scenario: for a time bound query for minister's
     When I send a query to the Test and Production Solr APIs with the params:
       | q     | minister's AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T23:59:59Z])   |
       | rows  | 20         |
	Then the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 5 in the Test response should be the same as result number 5 in the Production response
 	And result number 5 in the Test response should have the same text snippet as result number 5 in the Production response   
  
  Scenario: misspelled brexit query
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | brext   |
      | rows  | 20         |
	Then the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 5 in the Test response should be the same as result number 5 in the Production response
 	And result number 5 in the Test response should have the same text snippet as result number 5 in the Production response
	
  Scenario: time limited query of oaths
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])   |
      | rows  | 20         |
	Then the number of results returned by the Test response should equal the number of results returned by the Production response
	And result number 5 in the Test response should be the same as result number 5 in the Production response
 	And result number 5 in the Test response should have the same text snippet as result number 5 in the Production response
