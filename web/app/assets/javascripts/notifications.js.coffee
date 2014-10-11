@NotificationPoller =
	poll: ->
		setTimeout @request, 5000
	request:->
		$.get('/checkNewNotification')

jQuery ->
	if $('#notifications')
		NotificationPoller.poll()

