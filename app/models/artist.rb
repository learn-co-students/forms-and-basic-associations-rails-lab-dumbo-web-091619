class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def artist_name
    self.try(:artist).try(:name)
  end
  
end