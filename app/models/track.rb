class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true

  belongs_to :album

  def band_name
    self.album.band_name
  end
end
