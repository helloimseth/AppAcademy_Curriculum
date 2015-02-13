class Post < ActiveRecord::Base
  validates :sub_id, :user_id, :title, presence: true

  belongs_to :user

  belongs_to :sub




end
