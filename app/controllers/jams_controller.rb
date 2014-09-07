class JamsController < ApplicationController
  before_action :get_singer
  before_action :authorize_modify!, except: [:index, :show]

  def index
    # Show all songs in this singer's repertoire
    @songs = @singer.songs
  end

  def new
  end

  def create
    # Add song to repertoire
    @singer.add_song_to_repertoire params[:jam][:song_title], params[:jam][:artist_name]

    # Return to repertoire view
    redirect_to user_jams_path(@singer)
  end

  private
    def authorize_modify!
      # Redirect user to sign in if they're not yet
      authenticate_user!

      # Authorize user-owner or admin
      unless current_user == @singer || current_user.admin?
        # Redirect to repertoire view if not authorized
        flash[:alert] = "Only #{@singer.username} may edit their repertoire."
        redirect_to user_jams_path(@singer)
      end
    end

    def get_singer
      if params.include? :user_id
        @singer = User.friendly.find params[:user_id]
      else
        # Redirect user to sign in if they're not yet
        authenticate_user!

        @singer = current_user
      end
    end
end
