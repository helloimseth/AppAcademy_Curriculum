require 'sqlite3'
require 'singleton'
require_relative './models.rb'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end






class QuestionFollower
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?
      SQL
    QuestionFollower.new(fields.first)
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end



class QuestionLike
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
      SQL
    QuestionLike.new(fields.first)
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
