module ApplicationHelper

  # Determine active class for menu links
	def active_class_if_page(path)
    if current_page?(path)
      'active'
    end
  end

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true, fenced_code: true, gh_blockcode: true)
    markdown.render(text).html_safe
  end

end