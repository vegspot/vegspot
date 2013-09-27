module TagsHelper

  # Generate list of tags formatted as
  # downcased links with hashes before their names
  def tag_list_formatted(node)
    return_html = '<ul class="list-inline tags">'

    node.tags.each do |tag|
      return_html << content_tag(:li, link_to("##{tag.name.downcase}", '#'))
    end

    return_html << '</ul>'

    return return_html.html_safe  	
  end

end