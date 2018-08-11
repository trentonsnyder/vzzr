class Listing < ApplicationRecord
  belongs_to :company
  belongs_to :genre
  has_many :videos

  validates :name,
    presence: true
end