function lightbox () {
  const anchors = document.querySelectorAll('.m-img')
  if (anchors.length === 0) return

  const pswpElement = document.querySelector('.pswp')
  const options = {}

  function handleClick (e) {
    e.preventDefault()
    let index = 0
    for (index = 0; index < anchors.length - 1; index++) {
      if (anchors[index] === this) break
    }
    const gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, {
      index: index,
      bgOpacity: 0.85
    })
    gallery.init()
  }

  const items = []
  for (let anchor of anchors) {
    items.push({
      src: anchor.href,
      w: anchor.getAttribute('data-width'),
      h: anchor.getAttribute('data-height'),
      title: anchor.nextElementSibling && anchor.nextElementSibling.innerHTML
    })
    anchor.addEventListener('click', handleClick)
  }
}

lightbox()
