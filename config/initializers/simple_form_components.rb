module SimpleForm
  module Components
    module Typeahead
      def typeahead
        input_html_options['class'] ||= 'typeahead'
        input_html_options['data-source'] ||= options[:typeahead]
        nil
      end

      def has_typeahead
        typeahead.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Typeahead)
