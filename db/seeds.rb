if Rails.env.development?
  # Users
  admin = FactoryGirl.create :admin
  user  = FactoryGirl.create :user

  # Artists
  acdc    = FactoryGirl.create :artist, name: "AC/DC"
  beatles = FactoryGirl.create :artist, name: "The Beatles"

  # Songs
  norwegian_wood = FactoryGirl.create :song, artist: beatles, title: "Norwegian Wood"
  the_long_and   = FactoryGirl.create :song, artist: beatles, title: "The Long and Winding Road"
  thunderstruck  = FactoryGirl.create :song, artist: acdc,    title: "Thunderstruck"
  yes_it_is      = FactoryGirl.create :song, artist: beatles, title: "Yes It Is"

  # Repertoire
  FactoryGirl.create :jam, user: user, song: norwegian_wood
  FactoryGirl.create :jam, user: user, song: the_long_and
  FactoryGirl.create :jam, user: user, song: thunderstruck
  FactoryGirl.create :jam, user: user, song: yes_it_is
end
