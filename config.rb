# frozen_string_literal: true
require 'rouge'
require 'rouge/plugins/redcarpet'

configure :development do
  activate :livereload
end

activate :blog do |blog|
  blog.permalink = '{year}/{month}/{slug}'
  blog.summary_separator = "\n\n"
  blog.sources = 'articles/{year}-{month}-{day}-{slug}.html'
  blog.taglink = 'tagged/{tag}'
  blog.tag_template = 'tag.html'
  blog.layout = 'article'
end

page '/feed.xml', layout: false

helpers do
  def meta_description
    'a blog about ubuntu, sublime text and the web'
  end

  def link_to_github_article(current_article)
    url = [
      'https://github.com/mreq/mreq.eu/blob/master/source/articles/',
      current_article.date.year, '-',
      '%02d' % current_article.date.month, '-',
      '%02d' % current_article.date.day, '-',
      current_article.slug, '.html.md'
    ].join('')
    link_to 'fork this article on github', url, target: '_blank'
  end
end

class CustomMarkdownRenderer < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def initialize(extensions = {})
    super extensions.merge(link_attributes: { target: '_blank' })
  end

  def image(src, title, content)
    caption = content.present? ? %{
      <figcaption>#{content}</figcaption>
    } : nil

    %{<figure>
        <a href="/articles/images/#{src}">
          <img src="/articles/images/thumbs/#{src}" />
        </a>
        #{caption}
      </figure>}
  end
end

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               smartypants: true,
               renderer: CustomMarkdownRenderer

activate :syntax
activate :sprockets do |s|
  s.supported_output_extensions << '.es6'
end
activate :autoprefixer
activate :directory_indexes

sprockets.append_path File.join(root, 'bower_components')

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
  # Enable cache buster
  activate :asset_hash
end
