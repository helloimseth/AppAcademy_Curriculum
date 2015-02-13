class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :mod_id,
    primary_key: :id,
    inverse_of: :moderated_subs
end
