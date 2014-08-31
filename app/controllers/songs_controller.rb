class SongsController < ApplicationController
  def index
    if params.include? :starts_with
      # /songs?starts_with=:starts_with
      # Return all songs with titles beginning with :starts_with (i.e. autocomplete)
      songs = Song.starts_with(params[:starts_with])
    else
      # /songs
      # Return all songs
      @songs = Song.all
    end
    render json: songs.map { |song| { id: song.id, title: song.title, artist: song.artist.name } }
  end
end
