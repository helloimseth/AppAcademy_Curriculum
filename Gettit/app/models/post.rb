class Post < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to :user

  has_many :post_subs

  has_many :subs, through: :post_subs, source: :sub

  has_many :comments, dependent: :destroy

  def comments_by_parent_id
    comments_hash = Hash.new {|h,k| h[k] = []}
    comments_arr = self.comments

    comments_arr.each do |comment|
      comments_hash[comment.parent_id] << comment
    end

    comments_hash
  end
end
