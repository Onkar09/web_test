Feature: New Relic Errors monitoring

Scenario: New Relic crash monitor
  When I do new relic login
  And I open new relic errors
  Then I check the errors