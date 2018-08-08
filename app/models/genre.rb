class Genre < ApplicationRecord
  has_many :listings
  
  validates :name,
    presence: true,
    uniqueness: true

end