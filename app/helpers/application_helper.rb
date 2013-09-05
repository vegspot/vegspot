module ApplicationHelper

  # Determine active class for menu links
	def active_class_if_page(path)
    if current_page?(path)
      'active'
    end
  end

end