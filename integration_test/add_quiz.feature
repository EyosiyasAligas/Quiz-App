
# before running the test, make sure isIntegrationTest is set to true in theAppIsRunning function

Feature: Add Quiz

  Background:
    Given The app is running

  Scenario: add quiz
    When I tap {'addIcon'} widget
    And I enter <value> into <field> input field
      | field | value                                 |
      | 0     | 'Bio Quiz'                            |
      | 1     | 'What is the powerhouse of the cell?' |
      | 2     | 'Nucleus'                             |
      | 3     | 'Mitochondria'                        |
      | 4     | 'Ribosome'                            |
      | 5     | 'Endoplasmic Reticulum '              |
      | 6     | 'Endoplasmic Reticulum '              |
    And I tap {'Add Quiz'} text
    Then I see {'Bio Quiz'} added to the list

    Scenario: add quiz failure
        Then I see {'error widget'} displayed