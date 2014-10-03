module WizardHelper
  def wizard_progress(current_step, wizard_steps)
    current_step_number = wizard_steps.index(current_step).next
    total_steps = wizard_steps.size
    percentage_complete = (current_step_number.to_f / total_steps.to_f * 100).round
    content_tag :div, class: 'wizard_progress' do
      concat content_tag(:h2, "#{controller_path.split('/').first.singularize.titleize} Wizard")
      concat content_tag(:h4, "Step #{current_step_number} of #{total_steps}")
      concat (content_tag :div, nil, class: 'progress' do
        concat content_tag(:div, nil, class: 'bar', style:  "width: #{percentage_complete}%;")
      end)
      concat content_tag(:h3, step.to_s.titleize)
    end
  end
end
