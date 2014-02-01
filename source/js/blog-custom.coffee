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


$ ->
	initLightbox()