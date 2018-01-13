class MessagesList extends React.Component {
  render() {
    return (
      <div className='messages__list' ref={ (list) => { this.list = list } }>
        {
          this.props.messages.map((msg) => {
            return (
              <div className='messages__list__item' key={ msg.id }>
                <div className='message'>
                  <div className='message__title'>
                    <div className='message__title__username'>
                      { msg.user.username }
                    </div>
                    <div className='message__title__date'>
                      { msg.created_at }
                    </div>
                  </div>
                  <div className='message__body'>
                    { msg.body }
                  </div>
                </div>
              </div>
            )
          })
        }
      </div>
    )
  }

  componentDidUpdate() {
    this.list.scrollTop = this.list.scrollHeight
  }
}
