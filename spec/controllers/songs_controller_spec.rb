describe SongsController do
  include_examples "GET #index returns all or matching", :song, :title
end
