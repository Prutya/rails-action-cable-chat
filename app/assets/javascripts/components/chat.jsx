class Chat extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      messages: [],
      isLoadingMessages: false,
      errorLoadingMessages: false
    }

    this.onMessagesLoaded = this.onMessagesLoaded.bind(this)
    this.errorMessagesLoading = this.errorMessagesLoading.bind(this)
    this.onMessageReceived = this.onMessageReceived.bind(this)
    this.onMessageSent = this.onMessageSent.bind(this)
    this.errorMessageSending = this.errorMessageSending.bind(this)
    this.sendMessage = this.sendMessage.bind(this)
  }

  render() {
    return (
      <div className='messages'>
        <MessagesList messages={ this.state.messages }/>
        <MessagesForm sendMessage={ this.sendMessage }/>
      </div>
    )
  }

  componentDidMount() {
    this.loadMessages();
    this.initChannel();
  }

  loadMessages() {
    this.setState({
      isLoadingMessages: true
    })

    Rails.ajax({
      url: '/messages',
      type: 'GET',
      dataType: 'json',
      success: this.onMessagesLoaded,
      error: this.errorMessagesLoading
    })
  }

  onMessagesLoaded(data) {
    this.setState({
      messages: data.messages,
      isLoadingMessages: false
    })
  }

  errorMessagesLoading(error) {
    this.setState({
      isLoadingMessages: false,
      errorLoadingMessages: true
    })
  }

  initChannel() {
    App.cable.subscriptions.create('RoomChannel', {
      received: this.onMessageReceived
    })
  }

  onMessageReceived(data) {
    this.setState({
      messages: [ ...this.state.messages, data.message ]
    })
  }

  sendMessage(input) {
    this.setState({
      isSendingMessage: true
    })

    Rails.ajax({
      url: '/messages',
      type: 'POST',
      data: `message[body]=${input.value}`,
      success: () => { this.onMessageSent(input) },
      error: this.errorMessageSending
    })
  }

  onMessageSent(input) {
    this.setState({
      isSendingMessage: false
    })

    input.value = ''
  }

  errorMessageSending() {
    this.setState({
      errorSendingMessage: true
    })
  }
}
