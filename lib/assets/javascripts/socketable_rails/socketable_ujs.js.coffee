$ ->
	Url = do ->
		path: window.location.pathname
		host_with_port: window.location.host

	Websocketable = do ->
		selector = $('form[data-websocket]')
		exists   = ->
			selector.length > 0

		# return
		selector: selector
		exists: exists
		dispatcher: ->
			new WebSocketRails(Url.host_with_port+"/websocket")
		data: ->
			selector.serialize()
		onDefaultAction: (fn) ->
			selector.submit (e) ->
				e.preventDefault()
				fn()


	if Websocketable.exists
		io = Websocketable.dispatcher()

		Websocketable.onDefaultAction ->
			io.trigger('request', Websocketable.data().concat("&path=#{Url.path}"))

		io.bind 'test', (data) ->
			console.log data

