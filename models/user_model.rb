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
    questions_asked = Question.find_by_author_id(id)
  end

  def authored_replies
    replies_authored = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
      SQL

      replies_authored.map { |reply| Reply.new(reply) }
  end

end
