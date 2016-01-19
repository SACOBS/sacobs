module CoreExtensions
  module Numeric
    module PercentOf
      def percent_of(x=nil)
        (to_f / 100) * x
      end
    end
  end
end
