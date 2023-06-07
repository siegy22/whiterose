class ConversationsController < ApplicationController
  def index
    @latest_conversations = User.where(id: current_user.messages.pluck(:to_id, :from_id).flatten.uniq - [current_user.id])
    @latest_messages = current_user.messages.ordered.limit(20)
  end

  def show
    @recipient = User.find_by(username: params[:id])
    redirect_to new_conversation_path, notice: "User #{params[:id]} does not exist." unless @recipient

    @new_message = Message.new(to: @recipient)
    @messages = current_user.direct_messages_with(@recipient).ordered.limit(50).to_a
    # raise current_user.recevied_messages_from(@recipient).where(read_once: true).count.inspect
    current_user.recevied_messages_from(@recipient).where(read_once: true).destroy_all
  end

  def new
    @conversation = Conversation.new
  end

  def create
    redirect_to conversation_path(id: params.require(:conversation)[:username])
  end

  def pgp
    @recipient = User.find_by(username: params[:id])
  end

  def download_pgp
    @recipient = User.find_by(username: params[:id])
    send_data @recipient.pgp_public_key, filename: "#{@recipient.username}.pgp", disposition: :attachment
  end
end
