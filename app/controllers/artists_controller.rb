class ArtistsController < ApplicationController
  def index
    if params.include? :starts_with
      # /artists?starts_with=:starts_with
      # Return all artists with names beginning with :starts_with (i.e. autocomplete)
      artists = Artist.starts_with(params[:starts_with])
    else
      # /artists
      # Return all artists
      artists = Artist.all
    end
    render json: artists.map { |artist| { id: artist.id, name: artist.name } }
  end
end
