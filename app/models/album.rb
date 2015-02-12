class Album < ActiveRecord::Base
  validates :title, :band_id, presence: true
  
  belongs_to :band
  has_many :tracks
end
