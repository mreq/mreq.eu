###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

activate :blog do |blog|
  blog.permalink = "{year}/{month}/{slug}"
  blog.summary_separator = "/////"
  # blog.sources = "articles/{year}-{month}-{day}-{slug}.html"
  blog.sources = "articles/{year}-{month}-{day}-{slug}.html"
  blog.taglink = "tagged/{tag}"
  blog.tag_template = "tag.html"
  blog.layout = "article.html"
end

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true
activate :syntax

activate :directory_indexes

# haml messing code syntax
set :haml, { ugly: true }

# Methods defined in the helpers block are available in templates
helpers do
  def render_file(filename)
    contents = File.read(filename)
    Haml::Engine.new(contents).render
  end
end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
