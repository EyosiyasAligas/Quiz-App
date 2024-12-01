Feature: Fetch Quiz

  Background:
    Given The app is running

  Scenario: fetch quizzes from the server
    Then I see {'quizList'} fetched from the server


  Scenario: fetch quiz failure
    Then I see {'error widget'} displayed

#  Scenario: add quiz
#    When I tap {'addIcon'} widget
#    And I enter <value> into <field> input field
#      | field | value                                 |
#      | 0     | 'Bio Quiz'                            |
#      | 1     | 'What is the powerhouse of the cell?' |
#      | 2     | 'Nucleus'                             |
#      | 3     | 'Mitochondria'                        |
#      | 4     | 'Ribosome'                            |
#      | 5     | 'Endoplasmic Reticulum '              |
#      | 6     | 'Endoplasmic Reticulum '              |
#    And I tap {'Add Quiz'} text
#    Then I see {'Bio Quiz'} added to the list



#  Scenario: bottom sheet should be displayed
#    Given I am on the quiz screen
#    When I click on the {'+'} floating action button
#    Then I should see the quiz {'form'}
#
#  Scenario: add quiz
#    Given I am on the quiz screen
#    When I click on the {'+'} floating  action button
#    And I fill the quiz {'form'}
#    And I click on the {'add quiz'} button
#    Then I should see the {'quiz'} added to the list

