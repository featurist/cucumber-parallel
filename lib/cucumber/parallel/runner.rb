require 'parallel'
require 'json'

require 'cucumber/parallel'
require 'cucumber/parallel/filters'
require 'cucumber/parallel/main'
require 'cucumber/parallel/context'

module Cucumber
  module Parallel

    class Runner

      def initialize(args, stdout, stderr)
        @args = args
        @stdout = stdout
        @stderr = stderr
      end

      def run!
        contexts = scenario_contexts
        context_results = ::Parallel.map(contexts, {
            finish: lambda { |item, i, result|
              finished_scenario_in_context(item, i, result)
            },
            in_processes: 50 }) do |scenario_context|
          Parallel.context = scenario_context.context
          run_scenario(scenario_context.scenario, scenario_context.context)
        end
        Parallel.context = nil
        run_cucumber '', [
          ReplayParallelResults.new(context_results)
        ]
      end

      private

      def run_scenario(scenario, context)
        result = run_cucumber_as_json "#{scenario} --format json"
        scenario_element = result.first['elements'].first
        step_results = scenario_element['steps'].map { |step| step['result'] }
        ScenarioContextResult.new scenario, context, step_results
      end

      def finished_scenario_in_context(item, i, result)
        # $stdout << '.'
      end

      def run_cucumber(args, filters=[])
        output = StringIO.new
        err = StringIO.new
        Main.new(args.split(' '), output, err, filters).execute!
        output.string
      end

      def run_cucumber_as_json(args, filters=[])
        JSON.parse(run_cucumber args, filters)
      end

      def scenario_contexts
        scenarios.map do |scenario|
          contexts.map do |context|
            ScenarioContext.new(scenario, context)
          end
        end.flatten
      end

      def contexts
        (1..3)
      end

      def scenarios
        scenarios = []
        run_cucumber '--dry-run', [CaptureScenarios.new(scenarios)]
        scenarios
      end

    end

  end
end
