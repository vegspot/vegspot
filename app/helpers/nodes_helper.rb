module NodesHelper

  # Determine if widget-score should have
  # voted-for or voted-against class
  def voted_widget_class(node)
    return if !user_signed_in?

    if current_user.voted_for?(node)
      "voted-for"
    elsif current_user.voted_against?(node)
      "voted-against"
    end
  end

end