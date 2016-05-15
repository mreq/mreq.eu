#= require jquery/dist/jquery
#= require underscore/underscore
#= require backbone/backbone
#= require slick-carousel/slick/slick.js
#= require slick-lightbox/dist/slick-lightbox.js

initLightbox = ->
  return unless $('body').hasClass('m-article-page')
  wrap = $('#m-col')
  wrap.find('a > img').each ->
    t = $(this)
    title = t.attr('alt')
    t.attr('title', title)
    t.parent('a').addClass('m-img-link').attr('title', title).data('title', title)
  wrap.slickLightbox
    caption: 'title'
    background: 'rgba(255,255,255,.8)'
    useHistoryApi: true
    itemSelector: '.m-img-link'

initSearch = ->
  return if $('body').hasClass('m-article-page')
  wrap = $('.m-article-list')
  if wrap.length
    input = $('#m-search-input')

    Article = Backbone.Model.extend
      doesMatch: (val) ->
        @get('text').indexOf(val) isnt -1

    Articles = Backbone.Collection.extend
      model: Article

    articles = new Articles
    articleEls = wrap.children('article')

    initFun = ->
      unless articles.length
        articleEls.each ->
          t = $(this)
          tags = _.map t.find('.m-article-tags a'), (el) -> $(el).text()
          articles.add
            text: "#{t.find('h1, h2').text()} #{tags.join(',')}".replace(/[\n\r]/g, ' ').replace(/\s\s/g, ' ').toLowerCase()
            el: t
    init = _.once initFun

    scrollTop = ->
      $('html, body').animate scrollTop: 0

    change = (e) ->
      input.val('') if e?.keyCode? and e.keyCode is 27
      val = input.val().toLowerCase()
      window.location.hash = val
      if val is ''
        articleEls.removeClass('hide')
      else
        articles.each (a) ->
          a.get('el').toggleClass('hide', not a.doesMatch(val))

    input.one 'focus', init
    input.on
      keyup: change
      change: change

    handleHash = (tag) ->
      init()
      if not tag?
        if window.location.hash
          tag = window.location.hash.split('#').pop()
      if tag?
        input.val(tag)
        change()
        scrollTop()

    # init
    handleHash()

    # bind tag links
    wrap.on 'click', '.m-article-tags .m-article-tag-link', ->
      handleHash $(this).data('tag')

    $('#m-header').on 'click', '.m-tag-name', ->
      handleHash $(this).data('tag')

$ ->
  initLightbox()
  initSearch()
