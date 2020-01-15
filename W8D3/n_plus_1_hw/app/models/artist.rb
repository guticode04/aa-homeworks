class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
    discs = self
      .albums
      .select('albums.*, COUNT(*) AS tracks_count')
      .joins(:tracks)
      .group('albums.id')

    disc_counts = {}
    discs.each do |disc|
      disc_counts[disc.title] = disc.tracks_count
    end

    disc_counts
  end
end
