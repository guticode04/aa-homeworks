require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    data = PlayDBConnection.instance.execute(<<-SQL,title)
      SELECT 
        * 
      FROM 
        plays
      WHERE
        plays.title = ?
    SQL
    return nil unless data.length

    Play.new(data.first)
  end

  def self.find_by_playwright(name)
    
    playwright = Playwright.find_by_name(name)
    raise "#{name} is not in database" unless playwright

    data = PlayDBConnection.instance.executr(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      ON
        plays.playwright_id = ?
      WHERE
        playwrights.name = name
    SQL
    
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

end


#Playwright Class

class Playwright

  attr_accessor :id, :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)

    data = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        playwrights.name = ?
    SQL

    return nil unless data.length > 0

    Playwright.new(data.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already exists in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights (name,birth_year)
      VALUES
        (?,?)
    SQL

    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
      UPDATE
        playwrights
      SET
        playwrights.name = ?, playwrights.birth_year = ?
      WHERE
        playwrights.id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in db" unless self.id

    data = PlayDBConnection.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        playwrights
      WHERE 
        playwrights.id = ?
    SQL

    data.map { |datum| Play.new(datum)  }

  end
end