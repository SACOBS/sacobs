module ClientsHelper
  def alpha_pager(current_letter)
    content_tag :div, class: 'pagination pagination-centered' do
      content_tag :ul do
        ('A'..'Z').each do |letter|
          concat (content_tag :li, class: ('disabled' if letter == current_letter) do
                    link_to letter, clients_path(letter: letter)
                  end)
        end
      end
    end
  end

  def current_alpha_page(letter)
    letter || 'All'
  end
end
