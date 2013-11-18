module Responders
  module PDFResponder
    def initialize(controller, resources, options={})
      super
      @file_name = options.delete(:file_name)
    end

    def to_pdf
      render pdf: file_name, layout: 'pdf.html'
    end

    protected
    def file_name
      @file_name ||= "#{Time.zone.now.to_i}"
    end
  end
end