---
title: Easily load YAML fixtures to your rails app (including relations)
slug: easily-load-yaml-fixtures-to-your-rails-app
category: web
tags: web, rails
---

While creating a semi-CMS rails skeleton/template (see [shle](https://github.com/sinfin/shle)), I've been looking into ways of loading app data during development (and to kick off the production database). Currently, there are no good options for loading complex data structures including relations. That's what led me to writing a custom lib for the task. 

Imagine the following models:

```ruby
# app/models/category.rb
class Category < ActiveRecord::Base
  has_many :pages
end
```

```ruby
# app/models/page.rb
class Page < ActiveRecord::Base
  belongs_to :category

  has_many :content_parts,
           -> { where(contentable_type: 'Contentable') },
           dependent: :destroy,
           foreign_key: :contentable_id

  has_many :other_content_parts,
           -> { where(contentable_type: 'PageOther') },
           class_name: ContentPart,
           dependent: :destroy,
           foreign_key: :contentable_id
end
```

```ruby
# app/models/content_part.rb
class ContentPart < ActiveRecord::Base
  belongs_to :contentable, polymorphic: true
  has_many :images
end 
```

```ruby
# app/models/image.rb
class Image < ActiveRecord::Base
  belongs_to :content_part
  dragonfly_accessor :attachment
end
```

There's a `Page` having a content consisting of many `ContentPart`s. Each `ContentPart` can have multiple `Image`s. Such a structure is hard to seed in a human readable format. Rails has [FixtureSets](http://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html) built-in, which are unfortunately not very handy when it comes to relations.

What do I mean by human readable? Imagine the following ymls:

```yaml
# db/seeds/categories.yml
Category:
  - title: 'the first category'
    foo: 'bar'

  - title: 'the first category'
    foo: 'not bar'

  - title: 'another category title'
    bar: 'foo'
```

Alright, there's no difference to the regular fixtures. But how about this?

```yaml
# db/seeds/pages.yml
Page:
  - title: a page
    foo: bar
    category:
      title: 'the first category'
      foo: 'bar'
    content_parts:
      - markdown_text: |
            ## A h2

            paragraph
      - markdown_text: you name it
        images:
          - attachment: 'db/seeds/images/nova-green-energy.jpg'
          - attachment: 'https://placekitten.com/1170/450'
    other_content_parts:
      - text_cs: |
          ## other h2

          whatever

  - title: another page
    foo: bar
    category:
      title: 'another category title'
```

Note that to reference the `has_one` relation to `Category` I simply include some attributes, which are enough to `find_by` the correct one. The `has_many` relation is captured by simply providing an array of attributes.

We can create a similar yml for each model that we want to be seeded. To read the ymls and create appropriate data, we'll use the custom `YamlFixtureLoader` like this:

```ruby
# db/seeds.rb
Category.destroy_all
Page.destroy_all

models = %w(categories pages)
paths = models.map { |name| Rails.root.join("db/seeds/#{name}.yml") }
YamlFixtureLoader.new.load! paths
```

The class that I'm about to present handles:

+ **regular attributes** using `column_names`
+ **file attachments** when stored in the `attachment` attribute - this can be tweaked further - there's a simple adhoc solution for local/remote links, which can be definitely improved ([go fork the gist](https://gist.githubusercontent.com/mreq/2846000864a49c9b936dff77f224014e))
+ **relations** all of `has_many`, `has_one` and `belongs_to`; supports polymorphic versions as well

The code is (I believe) self-explanatory:

<pre><code class="ruby" data-remote="https://gist.githubusercontent.com/mreq/2846000864a49c9b936dff77f224014e">Loading...</code></pre>

If you tweak the code further, be sure to drop me a line here or at the gist comments. I'd love to hear from you.
