---
title: Easily export Backbone-relational models
slug: easily-export-backbone-relational-models
category: web
tags: web, backbonejs, coffeescript
---

To export a Backbone-relational model we can extend the original Backbone-relational model with three attributes and an export method./////

tl;dr, coffee version:

```coffee
Backbone.ExportableModel = Backbone.RelationalModel.extend
  exportAttributes: []
  exportChildren: []
  exportSiblings: [] 
  export: ->
    data = {}
    if @exportAttributes.length
      data = @pick.apply @, @exportAttributes
    if @exportSiblings.length
      for sibling in @exportSiblings
        data[sibling] = @get(sibling).export() if @get(sibling)?
    if @exportChildren.length
      for child in @exportChildren
        data[child] = @get(child).invoke 'export'
    data  
```

Such a model will have an `export()` method, which will gather all `exportAttributes` values, go through `exportChildren` (aka has-many) and `exportSiblings` (aka has-one) relations and call the `export()` method on them. That produces a nice structured JSON as result.

For an example of such a model:

```coffee
@App.M.FieldInstance = Backbone.ExportableModel.extend
  defaults: {}
  relations: [
    {
      type: Backbone.HasOne
      key: 'fieldInstanceImage'
      relatedModel: 'App.M.FieldInstanceImage'
      reverseRelation:
        includeInJSON: false
        type: Backbone.HasOne
        key: 'fieldInstance'
    }
  ]
  exportAttributes: ['type', 'width', 'height', 'x', 'y', 'points']
  exportSiblings: ['fieldInstanceImage']
```

To end with, I've included the compiled js version for non-coffee folk:

```js
Backbone.ExportableModel = Backbone.RelationalModel.extend({
  exportAttributes: [],
  exportChildren: [],
  exportSiblings: [],
  "export": function() {
    var child, data, sibling, _i, _j, _len, _len1, _ref, _ref1;

    data = {};
    if (this.exportAttributes.length) {
      data = this.pick.apply(this, this.exportAttributes);
    }
    if (this.exportSiblings.length) {
      _ref = this.exportSiblings;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        sibling = _ref[_i];
        if (this.get(sibling) != null) {
          data[sibling] = this.get(sibling)["export"]();
        }
      }
    }
    if (this.exportChildren.length) {
      _ref1 = this.exportChildren;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        child = _ref1[_j];
        data[child] = this.get(child).invoke('export');
      }
    }
    return data;
  }
});
```