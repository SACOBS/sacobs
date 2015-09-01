module LinkHelper

  def back_to(path)
    link_to path, class: 'btn btn-default' do
      fa_icon 'arrow-left', text: 'Back'
    end
  end
end
