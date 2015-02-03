require_relative './save_module.rb'

class User
  include SaveFunctions

  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
    User.new(fields.first)
  end

  def self.find_by_name(f_name, l_name)
    params = {f_name: f_name, l_name: l_name}

    fields = QuestionsDatabase.instance.execute(<<-SQL, params)
      SELECT
        *
      FROM
        users
      WHERE
        (f_name = :f_name AND l_name = :l_name)
      SQL
    User.new(fields.first)
  end

  attr_accessor :id, :f_name, :l_name

  def initialize( options = {} )
    @id = options['id']
    @f_name = options['f_name']
    @l_name = options['l_name']
  end

  def authored_questions
    Question.find_by_user_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    average_karma = QuestionsDatabase.instance.execute(<<-SQL, id)

      SELECT
        CAST(COUNT(DISTINCT(questions.id)) AS FLOAT)/COUNT(likings.question_id)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes as likings
      WHERE
        questions.user_id = ?

    SQL

    average_karma.first.values.first
  end


end
