module CoreExtensions
  module Numeric
    module PercentOf
      def percent_of(x=nil)
        (self.to_f / 100) * x
      end
    end
  end
end
