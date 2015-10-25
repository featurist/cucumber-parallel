require 'cucumber/parallel/runner'

module Cucumber
  module Parallel

    def self.context=(ctx)
      @context = ctx
    end

    def self.context
      @context
    end
  end
end
