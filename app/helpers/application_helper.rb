module ApplicationHelper

  # Determine active class for menu links
	def active_class_if_page(path)
    if current_page?(path)
      'active'
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true, fenced_code: true, gh_blockcode: true)
    markdown.render(text).html_safe
  end

end