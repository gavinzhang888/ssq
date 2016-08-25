$(
  ->
    R5App.notifications = R5App.cable.subscriptions.create "NotificationsChannel",
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        notification = data['notification']
        if notification
          content = notification['content']
          $.notify content, status: notification['level'], timeout: 5000, pos: "top-right", link: notification['link']

      # speak: (notification) ->
      #   @perform 'speak', notification: notification
)