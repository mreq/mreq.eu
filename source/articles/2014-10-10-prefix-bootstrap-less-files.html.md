---
title: Prefix bootstrap's less files
slug: prefix-bootstrap-less-files
category: web
tags: web, bootstrap, npm
---

I've created a simple npm tool to prefix bootstrap CSS classes.

You can find the tool on the [npm website](https://www.npmjs.org/package/bootstrap-prefixer) or on [github](https://github.com/mreq/bootstrap-prefixer).

To install:

```
npm install -g bootstrap-prefixer
```

To use:

```
bootstrap-prefixer [prefix] [path to bootstrap/less]
```

When prefixed with `s-`, the following `head -n27 bootstrap/carousel.less`

```less
//
// Carousel
// --------------------------------------------------


// Wrapper for the slide container and indicators
.carousel {
  position: relative;
}

.carousel-inner {
  position: relative;
  overflow: hidden;
  width: 100%;

  > .item {
    display: none;
    position: relative;
    .transition(.6s ease-in-out left);

    // Account for jankitude on images
    > img,
    > a > img {
      .img-responsive();
      line-height: 1;
    }
  }
```

becomes

```less
//
// Carousel
// --------------------------------------------------


// Wrapper for the slide container and indicators
.s-carousel {
  position: relative;
}

.s-carousel-inner {
  position: relative;
  overflow: hidden;
  width: 100%;

  > .s-item {
    display: none;
    position: relative;
    .s-transition(.6s ease-in-out left);

    // Account for jankitude on images
    > img,
    > a > img {
      &:extend(.s-img-responsive);
      line-height: 1;
    }
  }
```
