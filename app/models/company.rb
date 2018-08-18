class Company < ApplicationRecord
  has_many :users
  has_many :videos

  has_many :participants
  has_many :conversations, through: :participants

  has_many :message_read_states

  validates :kind,
    inclusion: { in: ['creator',  'publisher'] }

  def publisher?
    kind === "publisher"
  end

  def creator?
    kind === "creator"
  end
end