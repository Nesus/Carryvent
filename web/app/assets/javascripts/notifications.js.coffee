@NotificationPoller =
	poll: ->
		setTimeout @request, 15000
	request:->
		$.get('/checkNewNotification')

jQuery ->
	if $('#notifications')
		NotificationPoller.poll()

