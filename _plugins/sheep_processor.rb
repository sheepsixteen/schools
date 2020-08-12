# This is a custom markdown processor. Instaed of using kramdown's default,
# there are a few changes:
#
# 1) Code blocks have a `dir="rtl"` prop
# 2) Links to Youtube videos are automatically embedded

class Jekyll::Converters::Markdown::SheepProcessor
  def initialize(config)
    require 'kramdown'
    @config = config
  end

  def convert(content)
    ::Kramdown::Document.new(content, @config['kramdown']).to_sheep_html
  end
end
