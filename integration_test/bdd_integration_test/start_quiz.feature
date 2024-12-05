Feature: Start Quiz

  Background:
    Given The app is running

  Scenario: Fetch Category Success
    Then I see exactly {3} {DropdownMenu<Object>} widgets


  Scenario: Start quiz with random preferences
    When I tap {'Start Quiz'} text
    Then I see {'Random'} text
    And I see {'question 1'} displayed