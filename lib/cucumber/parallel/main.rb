module Cucumber
  module Parallel

    class Main
      def initialize(args, out=STDOUT, err=STDERR, filters=[], formats=[])
        @args    = args
        @out     = out
        @err     = err
        @filters = filters
        @formats = formats
      end

      def execute!
        Cucumber::Runtime.new(configuration).run!
      end

      def configuration
        @configuration ||= Cucumber::Cli::Configuration.new(@out, @err).tap do |configuration|
          configuration.parse!(@args)
          @filters.each { |f| configuration.filters << f }
          Cucumber.logger = configuration.log
        end
      end
    end

  end
end
