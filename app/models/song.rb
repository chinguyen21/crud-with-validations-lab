class Song < ApplicationRecord
  validates :title, presence: true
  validate :only_one_song
  validates :release_year, presence: true, if: :released
  validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}
  validates :artist_name, presence: true

  def only_one_song
    if Song.where.not(id: self.id).where('release_year = ?', self.release_year).any? {|song| song.artist_name == self.artist_name}
      errors.add(:artist_name, "Cannot release second song in the same year")
    end
  end


end
