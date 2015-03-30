class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :mod_id,
    primary_key: :id,
    inverse_of: :moderated_subs

  has_many :post_subs
  has_many :posts, through: :post_subs, source: :post
end
