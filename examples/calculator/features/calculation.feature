Feature: Calculation

  Scenario: Addition
    Given I start with 1
    When I add 2
    Then I have 3

  Scenario: Multiplication
    Given I start with 3
    When I multiply by 5
    Then I have 15

  Scenario: Division
    Given I start with 18
    When I divide by 3
    Then I have 6
