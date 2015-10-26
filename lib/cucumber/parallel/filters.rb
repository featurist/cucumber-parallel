require 'cucumber'
require 'cucumber/core'

module Cucumber
  module Parallel

    CaptureScenarios = Cucumber::Core::Filter.new(:scenarios) do
      def test_case(test_case)
        scenarios << test_case.location
        test_case.describe_to receiver
      end
    end

    ReplayParallelResults = Cucumber::Core::Filter.new(:context_results) do
      def test_case(test_case)
        results = context_results.select { |cr| cr.scenario == test_case.location }
        activated_steps = test_case.test_steps.map do |test_step|
          index = test_case.test_steps.index(test_step)
          step_results = results.map do |r|
            ContextStepResult.new(r.context, r.step_results[index])
          end
          test_step.with_action(test_step.action_location) do
            replay_step(test_step, index, step_results)
          end
        end
        test_case.with_steps(activated_steps).describe_to receiver
      end

      def replay_step(test_step, i, results)
        failures = results.select do |context_step_result|
          context_step_result.result['status'] == 'failed'
        end
        if failures.any?
          messages = failures.map do |failure|
            "\nFailed in context #{failure.context}:\n#{failure.result['error_message']}\n"
          end
          raise ContextFailures.new(messages.join("\n\n"))
        elsif results.first.result['status'] == 'skipped'
          raise Cucumber::Core::Test::Result::Skipped.new
        elsif results.first.result['status'] == 'undefined'
          raise Cucumber::Core::Test::Result::Undefined.new
        end
      end
    end

  end
end
