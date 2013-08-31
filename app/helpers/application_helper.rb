module ApplicationHelper

  # Determine active class for menu links
	def active_class_if_page(path)
    if current_page?(path)
      'active'
    end
  end

  # Determine if widget-score should have
  # voted-for or voted-against class
  def voted_widget_class(node)
    if current_user.voted_for?(node)
      "voted-for"
    elsif current_user.voted_against?(node)
      "voted-against"
    end
  end

end