require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end

class User
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
    User.new(fields)
  end

  attr_accessor :id, :f_name, :l_name

  def initialize( options = {} )
    @id = options['id']
    @f_name = options['f_name']
    @l_name = options['l_name']
  end

end


class Question
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL
    Question.new(fields)
  end

  attr_accessor :id, :user_id, :body

  def initialize( options = {} )
    @id = options['id']
    @user_id = options['user_id']
    @body = options['body']
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
    QuestionFollower.new(fields)
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end


class Reply
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
    Reply.new(fields)
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
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
    QuestionLike.new(fields)
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
