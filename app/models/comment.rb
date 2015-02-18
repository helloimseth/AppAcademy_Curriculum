class Comment < ActiveRecord::Base
  validates :comment, :commentable_id, :commentable_type, :author, presence: true

  belongs_to :commentable, polymorphic: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    inverse_of: :authored_comments
end
