---
title: SVG clientWidth in Firefox
slug: svg-clientwidth-in-firefox
category: web
tags: web, firefox, svg
---

Be careful when playing with `clientWidth` and masking SVG elements.

Each element "hidden" in `<defs>` will have a zero `clientWidth`, `clientTop` etc. in Firefox.

```svg
<svg xmlns="http://www.w3.org/2000/svg" version="1.1"
  width="100%" height="100%" xlink="http://www.w3.org/1999/xlink">
  <ellipse
    id="IdoHaveClientWidth"
    rx="10%" ry="20%" cx="50%" cy="55%">
  </ellipse>
  <defs>
    <mask>
      <ellipse
        id="IhaveNoClientWidth"
        rx="10%" ry="20%" cx="50%" cy="55%">
      </ellipse>
    </mask>
  </defs>
</svg>
```

To get the real dimensions, you'll have to clone the element and insert it as a direct child of the SVG tag. This applies to the current Firefox version - 22.0.
