---
title: Dealing with slow backbone-relational models cloning
slug: dealing-with-slow-backbone-relational-models-cloning
category: web
tags: web, backbonejs, coffeescript
---

Be careful when working with backbone-relational and cloning elements./////

If you do clone elements using `toJSON` method, be sure to specify `includeInJSON: false` in the model definition, eg.

```coffee
relations: [
  {
    type: Backbone.HasOne
    key: 'fieldInstance'
    relatedModel: 'App.M.FieldInstance'
    reverseRelation:
      includeInJSON: false
      type: Backbone.HasOne
      key: 'fieldInstanceImage'
  }
]
```

Otherwise, you'll end up with a heckload of objects and the app will be unusable with 5+ cloned models.