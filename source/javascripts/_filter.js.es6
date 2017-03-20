const niceHash = () => window.location.hash.split('#').pop().toLowerCase()

function toggleArticles (hash, articles) {
  function toggleArticle (index) {
    const article = articles[index]
    let className = article.node.className
    if (article.matcher.indexOf(hash) === -1) {
      if (article.node.className.indexOf('m-hidden') === -1) {
        article.node.className += ' m-hidden'
      }
    } else {
      if (article.node.className.indexOf('m-hidden') !== -1) {
        article.node.className = article.node.className.replace('m-hidden', '')
      }
    }
  }

  Object.keys(articles).forEach(toggleArticle)
}

function articleFilter () {
  const input = document.getElementById('m-input')
  if (!input) return

  function getMatcher (article) {
    const matchers = []
    for (let node of article.querySelectorAll('.m-tag-a, h2')) {
      matchers.push(node.innerHTML.toLowerCase())
    }
    return matchers.join("\n")
  }

  const articles = []
  for (let article of document.querySelectorAll('.m-article-perex')) {
    articles.push({
      node: article,
      matcher: getMatcher(article)
    })
  }

  const onInputChange = () => window.location.hash = input.value

  input.addEventListener('keyup', onInputChange)
  input.addEventListener('change', onInputChange)

  const checkHash = () => {
    input.value = niceHash()
    toggleArticles(niceHash(), articles)
  }

  window.onhashchange = checkHash
  checkHash()
}

articleFilter()
