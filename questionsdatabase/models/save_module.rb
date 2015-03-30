module SaveMethods

  def save
    id.nil? ? insert : update
  end

  def insert
    fields = variables
    qmarks = '?,' * (fields.count - 1) + "?"

    QuestionsDatabase.instance.execute(<<-SQL, *fields.values)
      INSERT INTO
        #{table}#{columns}
      VALUES
        (#{qmarks})
      SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL)
    UPDATE
      #{table}
    SET
      #{update_string}
    WHERE
      id = \'#{find_id}\'
    SQL
  end

  def variables
    fields = Hash.new

    self.instance_variables[1..-1].each do |var|
      fields[var] = self.instance_variable_get(var)
    end

    fields
  end

  def find_id
    self.instance_variable_get(instance_variables[0])
  end

  def update_string
    fields = variables.keys
    fields += variables.values
    half = fields.count/2

    string = String.new

    fields.each_with_index do |field, index|
      next if index >= half
      string += "#{field.to_s.sub('@', '')} = \'#{fields[index + half]}\'"
      string += ",\n" unless index >= fields.count - (half + 1)
    end

    string
  end

end
