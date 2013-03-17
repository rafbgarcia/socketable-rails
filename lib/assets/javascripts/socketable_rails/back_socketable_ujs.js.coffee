Url = do ->
	path: window.location.pathname
	host_with_port: window.location.host

Socketable = do ->
	@socket =
	selector = $('form[data-websocket]')
	exists   = ->
		selector.length > 0

	# return
	selector: selector
	exists: exists
	dispatcher: new WebSocketRails(Url.host_with_port+"/websocket")
	data: ->
		selector.serialize()
	onDefaultAction: (fn) ->
		selector.submit (e) ->
			e.preventDefault()
			fn()

$ ->
	if Socketable.exists
		io = Socketable.dispatcher

		Socketable.onDefaultAction ->
			io.trigger('request', Socketable.data().concat("&path=#{Url.path}"))
