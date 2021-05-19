require_relative 'questionsdatabase'
require_relative 'user'
require_relative 'reply'

class Question
  attr_accessor :id, :title, :body, :associated_author

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    return nil if question.length <= 0 # might be <= 0
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        associated_author = ?
    SQL

    return nil if question.length <= 0 # might be <= 0
    # Question.new(question.first)
    question.map {|ob| Question.new(ob)}
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @associated_author = options['associated_author']
  end

  def author
    # Question.find_by_author_id(@associated_author)
    user = QuestionsDatabase.instance.execute(<<-SQL, @associated_author)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil if user.length <= 0 # might be <= 0
    User.new(user.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end


end