class Video < ApplicationRecord
  has_many :views
  belongs_to :listing
end