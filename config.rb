configure :development do
  activate :livereload
end

activate :blog do |blog|
  blog.permalink = '{year}/{month}/{slug}'
  blog.summary_separator = '/////'
  blog.sources = 'articles/{year}-{month}-{day}-{slug}.html'
  blog.taglink = 'tagged/{tag}'
  blog.tag_template = 'tag.html'
  blog.layout = 'article'
end

page '/feed.xml', layout: false

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

activate :syntax
activate :sprockets
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
