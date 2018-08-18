class Video < ApplicationRecord
  belongs_to :company
  belongs_to :genre
  has_many :views

  validates :name,
    presence: true
end