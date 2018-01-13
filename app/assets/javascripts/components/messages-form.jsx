class MessagesForm extends React.Component {
  constructor(props) {
    super(props)

    this.handleSendClick = this.handleSendClick.bind(this)
  }

  render() {
    return (
      <div className='messages__form'>
        <textarea
          ref={ (input) => { this.inputBody = input } }
          placeholder='Type your message here'
          className='messages__form__input'>
        </textarea>
        <button
          className='messages__form__button'
          onClick={this.handleSendClick}>
          Send
        </button>
      </div>
    )
  }

  handleSendClick() {
    this.props.sendMessage(this.inputBody)
  }
}
