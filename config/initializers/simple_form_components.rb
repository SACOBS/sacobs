module SimpleForm
  module Components
    module Typeahead
      def typeahead
        unless typeahead_source.empty?
          input_html_options['data-provide'] ||= 'typeahead'
          input_html_options['data-items'] ||= 5
          input_html_options['data-source'] ||= typeahead_source.inspect.to_s
          nil
        end
      end

      def typeahead_source
        tdata = options[:typeahead]
        return Array(tdata)
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Typeahead)