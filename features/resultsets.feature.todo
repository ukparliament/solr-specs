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

  Scenario: Checking results for the query on the Test API: oaths allegiance type:"parliamentary proceedings" session:21/22
    Given I have typed in the query: oaths allegiance type:"parliamentary proceedings" session:21/22
    When the Solr query is: (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND allegiance AND type_sesrollup:352179^0 AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T23:59:59Z])
    Then the number of results from the Test API should be 4

  Scenario: Checking results for the query on the Prod API: oaths allegiance type:"parliamentary proceedings" session:21/22
    Given I have typed in the query: oaths allegiance type:"parliamentary proceedings" session:21/22
    When the Solr query is: (Oaths OR Affirmations OR all_ses:92212 OR "Oaths and affirmations") AND allegiance AND (type_sesrollup:352179^0 OR type_t:"parliamentary proceedings"^0) AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])
    Then the number of results from the Prod API should be 4

  Scenario: Comparing results for the query: rental session:21/22
    Given I have typed in the query: rental session:21/22
    When the Solr query is: rental AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T23:59:59Z])
    Then the number of results from the Test API should be 46
    And the number of results from the Prod API should be 39

  Scenario: Comparing results for the query: title:"asylum: housing" session:21/22
    Given I have typed in the query: title:"asylum: housing" session:21/22
    When the Solr query is: title_t:"asylum:housing" AND (session_s:2021-22 OR date_dt:[2021-05-11T00:00:00Z TO 2022-04-28T22:59:59Z])
    Then the number of results from the Test API should be 0
    And the number of results from the Prod API should be 29