class Question < ActiveRecord::Base
  validates :question_text, :poll_id, presence: true

end
