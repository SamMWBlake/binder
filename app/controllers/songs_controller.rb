class SongsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize_modify, only: [:new, :create, :destroy]

  def index
    if params.include? :user_id
      # /users/:user_id/songs
      # Show all songs associated with this user
      user = User.friendly.find(params[:user_id])
      @songs = user.songs

      # Signed-in users can add songs to their own lists
      if user_signed_in? and current_user == user
        @can_add = true
      end
    else
      if params.include? :starts_with
        # /songs?starts_with=:starts_with
        # Return all songs with titles beginning with :starts_with (i.e. autocomplete)
        songs = Song.starts_with(params[:starts_with])
        render json: songs.map { |song| {id: song.id, title: song.title, artist: song.artist.name} }
      else
        # /songs
        if user_signed_in?
          # Show all songs associated with the logged-in user
          redirect_to user_songs_path(current_user)
        else
          # Show all songs
          @songs = Song.all
        end
      end
    end
  end

  def new
  end

  def create
    # Find or create song
    artist = Artist.find_or_create_by(name: params[:song][:artist])
    song = Song.find_or_create_by(title: params[:song][:title], artist_id: artist.id);

    # Create repertoire entry (association between user and song)
    user = User.friendly.find(params[:user_id])
    user.songs << song unless user.songs.include? song

    redirect_to user_songs_path
  end

  def destroy
    # Delete repertoire entry (if it exists)
    user = User.friendly.find(params[:user_id])
    song = Song.find(params[:id])
    user.songs.delete(song)

    redirect_to user_songs_path
  end

  private
    def authorize_modify
      unless user_signed_in? and (current_user == User.friendly.find(params[:user_id]) or current_user.admin?)
        redirect_to user_songs_path
      end
    end
end
