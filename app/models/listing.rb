class Listing < ApplicationRecord
  belongs_to :company
  belongs_to :genre
  
  validates :name,
    presence: true
end