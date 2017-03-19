function callAjax (url, callback) {
  var xmlhttp
  xmlhttp = new XMLHttpRequest()
  xmlhttp.onreadystatechange = function () {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
      callback(xmlhttp.responseText)
    }
  }
  xmlhttp.open('GET', url, true)
  xmlhttp.send()
}

const createGistLink = (url) => {
  const link = document.createElement('a')
  link.className = 'm-fork-gist'
  link.href = url
  link.target = '_blank'
  link.title = 'fork this gist'
  return link
}

const wrapPre = (pre) => {
  const div = document.createElement('div')
  div.className = 'm-pre'
  pre.parentNode.insertBefore(div, pre)
  div.appendChild(pre)
  return div
}

const gists = document.querySelectorAll('[data-remote]')
for (let gist of gists) {
  let url = gist.getAttribute('data-remote')

  let replace = (content) => {
    let pre = gist.parentNode
    let wrap = wrapPre(pre)
    gist.innerHTML = content
    wrap.appendChild(createGistLink(url))
  }

  callAjax(`${url}/raw`, replace)
}
