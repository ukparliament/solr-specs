Feature: Query resultset expectations
  Comparing resultsets from each Solr API

  Scenario: Comparing results for the query: "minister's" session:21/22
    Given I have typed in the query: "minister's" session:21/22
    When the Solr query is: minister's AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T23:59:59Z])
    Then the number of results from the Test API should be 246
    And the number of results from the Prod API should be 43791

  Scenario: Comparing results for the query: oaths session:21/22
    Given I have typed in the query: oaths session:21/22
    When the Solr query is: (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])
    Then the number of results from the Test API should be 27
    And the number of results from the Prod API should be 907

  Scenario: Comparing results for the query: [oaths] session:21/22
    Given I have typed in the query: [oaths] session:21/22
    When the Solr query is: oaths AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])
    Then the number of results from the Test API should be 18
    And the number of results from the Prod API should be 105