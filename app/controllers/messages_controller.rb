class MessagesController < ApplicationController
  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params.merge(from: current_user))
    @message.encrypt_if_necessary!

    @message.save
    redirect_to(conversation_path(@message.to))
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "Message was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :to_id, :read_once)
  end
end
