class MessagesController < ApplicationController
  before_action :load_messages, only: %i[index create]
  before_action :build_message, only: %i[index create]

  def index
  end

  def create
    message = current_user.messages.build(params_create)

    if message.save
      ActionCable.server.broadcast('room_channel', {
        message: {
          id:         message.id,
          body:       message.body,
          created_at: message.created_at,

          user: {
            id:       message.user.id,
            username: message.user.username
          }
        }
      })

      return render json: { status: 'ok' }, status: :ok
    end

    render json: { status: 'bad_request' }, status: :bad_request
  end

  private

  def load_messages
    @messages = Message.includes(:user).latest
  end

  def build_message
    @message  = current_user.messages.build
  end

  def params_create
    # TODO: Rails ujs does not allow to send json???
    (JSON.parse(params.to_unsafe_hash.to_a[0][0]))['message'].symbolize_keys
  end
end
