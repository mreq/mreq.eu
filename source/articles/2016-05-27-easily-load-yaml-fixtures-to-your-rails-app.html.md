---
title: Easily load YAML fixtures to your rails app (including relations)
slug: easily-load-yaml-fixtures-to-your-rails-app
category: web
tags: web, rails
---

While creating a semi-CMS rails skeleton/template (see [shle](https://github.com/sinfin/shle)), I've been looking into ways of loading data to the app. Currently, there are no good options for loading complex data including relations. That's what led me to writing a custom lib for the task. /////

Imagine the following models.

```ruby
class Page < ActiveRecord::Base
  has_many :content_parts
end

class ContentPart < ActiveRecord::Base
  belongs_to :page
  has_many :images
end 
```

<pre class="highlight ruby" data-remote="https://gist.githubusercontent.com/mreq/2846000864a49c9b936dff77f224014e/raw">Loading...</pre>
