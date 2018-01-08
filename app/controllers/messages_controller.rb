class MessagesController < ApplicationController
  before_action :load_messages, only: %i[index create]
  before_action :build_message, only: %i[index create]

  def index
  end

  def create
    message = current_user.messages.build(params_create)

    if message.save
      return redirect_to(messages_url)
    end

    render :index
  end

  private

  def load_messages
    @messages = Message.latest
  end

  def build_message
    @message  = current_user.messages.build
  end

  def params_create
    params.require(:message).permit(:body)
  end
end
