class Note < ActiveRecord::Base
  validates :user_id, :track_id, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :track
end
