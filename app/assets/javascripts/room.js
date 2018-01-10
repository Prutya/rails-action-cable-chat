App.room = App.cable.subscriptions.create(
  'RoomChannel',
  {
    connected: function() {
    },
    disconnected: function() {
    },
    received: function(data) {
      var messagesList = document.querySelectorAll('.messages__list');
      if (messagesList.length < 1) { return; }

      var messageWrapper = document.createElement('div');
      messageWrapper.setAttribute('class', 'messages__list__item');

      var messageNode = document.createElement('div');
      messageNode.setAttribute('class', 'message');

      var messageUsername = document.createElement('div');
      messageUsername.setAttribute('class', 'message__username');
      messageUsername.innerText = data.message.user.username;

      var messageBody = document.createElement('div');
      messageBody.setAttribute('class', 'message__body');
      messageBody.innerText = data.message.body;

      messageNode.append(messageUsername);
      messageNode.append(messageBody);
      messageWrapper.append(messageNode);

      for (var i = 0; i < messagesList.length; i++) {
        messagesList[i].append(messageWrapper);
      }
    }
  }
)
