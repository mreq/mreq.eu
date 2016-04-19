#= require jquery/dist/jquery
#= require underscore/underscore
#= require backbone/backbone

initLightbox = ->
	wrap = $('#m-col')
	imgs = wrap.find('a > img')
	imgs.each ->
		t = $(this)
		t.parent('a').attr('title', t.attr('alt'))
	imgs.parent('a').magnificPopup
		type: 'image'
		gallery:
			enabled: true
			preload: [0,2]

initSearch = ->
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

		# init
		handleHash()
		# bind tag links
		wrap.on 'click', '.m-article-tags .m-article-tag-link', ->
			handleHash $(this).data('tag')
		$('#m-header').on 'click', '.m-tag-name', ->
			handleHash $(this).data('tag')

$ ->
	# initLightbox()
	initSearch()
