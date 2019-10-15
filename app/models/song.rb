class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def note_contents=(content)
    # byebug
    content.each{|c|
    if c.empty?
    else
      self.notes << Note.find_or_create_by(content: c, id: self.id)
    end
  }
  end

  def note_contents
    # self.notes.select{ |c| !c.content.chars.include?("/") }.map(&:content)
    self.notes.map(&:content)
  end

  def notes_1
    self.notes.first ? self.notes.first.content : nil
  end

  def notes_2
    self.notes.last ? self.notes.last.content : nil
  end

end
