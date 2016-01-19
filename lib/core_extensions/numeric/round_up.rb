module CoreExtensions
  module Numeric
    module RoundUp
      def round_up(nearest=1)
        (self / nearest.to_f).ceil * nearest
      end
    end
  end
end
