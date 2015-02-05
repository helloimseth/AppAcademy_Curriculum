class Response < ActiveRecord::Base
  validates :user_id, :question_id, presence: true
  
end
