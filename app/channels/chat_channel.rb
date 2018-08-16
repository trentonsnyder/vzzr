class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "company_#{params['company_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
