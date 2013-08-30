module TagsHelper

  def tags_as_labels(node)
    return_html = ''

    node.tags.each do |tag|
      return_html << link_to(tag.name, '#', class: 'label label-tag')
    end

    return return_html.html_safe
  end

end