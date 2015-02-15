class Post < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to :user

  has_many :post_subs

  has_many :subs, through: :post_subs, source: :sub

  has_many :comments, dependent: :destroy

end
