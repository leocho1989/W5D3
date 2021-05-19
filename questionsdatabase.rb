require 'sqlite3'
require 'Singleton'

class QuestionsDatabase < SQLite3::Database

include Singleton
end