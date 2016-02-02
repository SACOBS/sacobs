module WizardHelper

  def step_number(step, steps)
    steps.index(step).next
  end

  def total_steps(steps)
    steps.size
  end

  def wizard_completion_percentage(step, total_steps)
    ((step.to_f / total_steps.to_f) * 100).round
  end

  def wizard_name
    controller_path.split('/').first.singularize.titleize
  end
end
