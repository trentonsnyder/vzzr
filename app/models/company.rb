class Company < ApplicationRecord
  has_many :users
  has_many :listings

  validates :kind,
    inclusion: { in: ['creator',  'publisher'] }

  def publisher?
    kind === "publisher"
  end

  def creator?
    kind === "creator"
  end
end