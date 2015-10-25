module Cucumber
  module Parallel

    class ContextStepResult
      def initialize(context, result)
        @context, @result = context, result
      end
      attr_reader :context, :result
    end

    class ContextFailures < Exception
      def backtrace
        []
      end
    end

    class ScenarioContext
      def initialize(scenario, context)
        @scenario = scenario
        @context = context
      end

      attr_reader :scenario, :context
    end

    class ScenarioContextResult
      def initialize(scenario, context, step_results)
        @scenario = scenario
        @context = context
        @step_results = step_results
      end

      attr_reader :scenario, :context, :step_results
    end

  end
end
