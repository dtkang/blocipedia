module ApplicationHelper
  def markdown(text)
    #extensions = [:hard_wrap, :filter_html, :autolink, :no_intra_emphasis, :fenced_code_blocks]
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, disable_indented_code_blocks: true, autolink: true, no_intra_emphasis: true, fenced_code_blocks: true)
    markdown.render(text).html_safe
  end
end
