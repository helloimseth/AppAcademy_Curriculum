class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :answer_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

end
