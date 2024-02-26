Feature: Solr API matching
  Exploring the differences between Test and Production Solr APIs
  
  Scenario: Checking the Test and Production Solr APIs are returning the same number of results for the query farming
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | farming   |
      | rows  | 20         |
	And the number of results returned by the Test response should equal the number of results returned by the Production response
	
  Scenario: Checking the Test and Production Solr APIs are returning results in the same order for the query farming
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | farming   |
      | rows  | 20         |
	And result number 5 in the Test response should be the same as result number 5 in the Production response

  Scenario: Checking the Test and Production Solr APIs are returning the same number of results for a time limited query of oaths
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])   |
      | rows  | 20         |
	And the number of results returned by the Test response should equal the number of results returned by the Production response
	
  Scenario: Checking the Test and Production Solr APIs are returning results in the same order for  for a time limited query of oaths
    When I send a query to the Test and Production Solr APIs with the params:
      | q     | (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])   |
      | rows  | 20         |
	And result number 5 in the Test response should be the same as result number 5 in the Production response




