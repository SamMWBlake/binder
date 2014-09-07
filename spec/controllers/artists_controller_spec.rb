describe ArtistsController do
  include_examples "GET #index returns all or matching", :artist, :name
end
