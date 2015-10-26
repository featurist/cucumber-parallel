# cucumber-parallel

** Work In Progress! **

## Not much yet, but...

```
> cd examples/calculator
> rake
```
...runs `cucumber_parallel`, which runs each scenario 3 times (or in 3 different
*contexts*) in parallel. The errors from each different context are concatenated
into a single error message, so cucumber formatters work as expected, just with
longer error messages:
```
../../bin/cucumber_parallel
Feature: Calculation

  Scenario: Addition     # features/calculation.feature:3
    Given I start with 1 # features/step_definitions/steps.rb:1
    When I add 2         # features/step_definitions/steps.rb:6
    Then I have 3        # features/step_definitions/steps.rb:16

  Scenario: Multiplication # features/calculation.feature:8
    Given I start with 3   # features/step_definitions/steps.rb:1
    When I multiply by 5   # features/step_definitions/steps.rb:10

      Failed in context 2:
      Multiplication failed in context 2 (RuntimeError)
      ./features/step_definitions/steps.rb:12:in `/^I multiply by (\d+)$/'
      features/calculation.feature:10:in `When I multiply by 5'


      Failed in context 3:
      Multiplication failed in context 3 (RuntimeError)
      ./features/step_definitions/steps.rb:12:in `/^I multiply by (\d+)$/'
      features/calculation.feature:10:in `When I multiply by 5'
       (Cucumber::Parallel::ContextFailures)
    Then I have 15         # features/step_definitions/steps.rb:16

  Scenario: Division      # features/calculation.feature:13
    Given I start with 18 # features/step_definitions/steps.rb:1
    When I divide by 3    # features/calculation.feature:15
    Then I have 6         # features/step_definitions/steps.rb:16

Failing Scenarios:
cucumber features/calculation.feature:8 # Scenario: Multiplication

3 scenarios (1 failed, 1 undefined, 1 passed)
9 steps (1 failed, 2 skipped, 1 undefined, 5 passed)
0m0.028s

You can implement step definitions for undefined steps with these snippets:

When(/^I divide by (\d+)$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end
```
