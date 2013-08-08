class SongsController < ApplicationController
  def index
    @songs = User.find(params[:user_id]).songs
  end

  def create
    # Create repertoire entry (association between user and song)
    @user = User.find(params[:user_id])
    @song = Song.find(params[:song][:id])
    @user.songs << @song unless @user.songs.include? @song

    redirect_to user_songs_path(@user)
  end

  def destroy
    # Delete repertoire entry (if it exists)
    @user = User.find(params[:user_id])
    @song = Song.find(params[:id])
    @user.songs.delete(@song)

    redirect_to user_songs_path(@user)
  end
end
