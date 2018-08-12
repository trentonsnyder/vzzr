class MessageReadState < ApplicationRecord
  belongs_to :company
  belongs_to :message
end