module WizardHelper
  def wizard_progress(current_step, wizard_steps)
    current_step_number = wizard_steps.index(current_step).next
    total_steps = wizard_steps.size
    percentage_complete = completion_percentage(current_step_number, total_steps)
    progress_div(current_step_number, total_steps, percentage_complete)
  end

  private

  def progress_div(current_step_number, total_steps, percentage_complete)
    content_tag :div, class: "wizard_progress" do
      concat content_tag(:h2, "#{wizard_name} Wizard")
      concat content_tag(:h4, "Step #{current_step_number} of #{total_steps}")
      concat content_tag :div, nil, class: "progress" do
        concat content_tag(:div,
                           nil,
                           class: "progress-bar",
                           role:  "progressbar",
                           style: "width: #{percentage_complete}%;")
      end
      concat content_tag(:h3, step.to_s.titleize)
    end
  end

  def completion_percentage(step, total_steps)
    (step.to_f / total_steps.to_f * 100).round
  end

  def wizard_name
    controller_path.split("/").first.singularize.titleize
  end
end
