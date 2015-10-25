require 'cucumber/parallel/runner'

module Cucumber
  module Parallel
    class CLI
      def self.run!(stdin, stdout, stderr, args)
        puts Runner.new(args, stdout, stderr).run!
      end
    end
  end
end
