module Utilities
  module Calculations
    extend self

    def round_up(value, by = 1)
      (value / by.to_f).ceil * by
    end

    def percentage_of(percent, value)
      (percent.to_f / 100) * value
    end
 end
end
