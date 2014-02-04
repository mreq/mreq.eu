---
title: Global bootstrap-modal callback
slug: global-bootstrap-modal-callback
category: web
tags: web, bootstrap, coffeescript
---

If you are in need of a global callback for bootstrap modal, you can use the fired events.///// Simply add the following jQuery in coffeescript:

```coffee
# coffee
$('body').on 'show', '> .modal', ->
	console.log 'Modal is being shown.'
```

or plain javascript:

```js
// js
$('body').on('show', '> .modal', function() {
	console.log('Modal is being shown.');
});
```

Note the `>` selector, which saves a lot of DOM traversing.