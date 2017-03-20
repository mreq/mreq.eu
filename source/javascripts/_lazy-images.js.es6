for (let anchor of document.querySelectorAll('.m-img')) {
  let image = new Image()
  imagesLoaded(image, () => {
    anchor.children[0].appendChild(image)
    setTimeout(() => { image.className = 'm-visible' }, 0)
  })
  image.src = anchor.href
}
