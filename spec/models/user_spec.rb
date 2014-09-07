describe User do
  it { should have_many(:jams) }
  it { should have_many(:songs).through(:jams) }

  describe '::find_first_by_auth_conditions' do
    # Tested by feature specs
  end

  describe '#add_song_to_repertoire' do
    let(:user) { create :user }

    context "when neither song nor artist exists" do
      let(:artist_name) { "name" }
      let(:song_title)  { "title" }

      before do
        user.add_song_to_repertoire song_title, artist_name
      end

      it "should create artist" do
        expect(Artist.all.count).to eq 1
      end

      it "should create song" do
        expect(Song.all.count).to eq 1
      end

      it "should add song to repertoire" do
        expect(user.songs.count).to eq 1
        expect(user.songs.first.artist.name).to eq artist_name
        expect(user.songs.first.title).to eq song_title
      end
    end

    context "when artist already exists" do
      let(:artist)     { create :artist }
      let(:song_title) { "title" }

      before do
        user.add_song_to_repertoire song_title, artist.name
      end

      it "should not duplicate artist" do
        expect(Artist.all.count).to eq 1
      end

      it "should create song" do
        expect(Song.all.count).to eq 1
      end

      it "should add song to repertoire" do
        expect(user.songs.count).to eq 1
        expect(user.songs.first.artist).to eq artist
        expect(user.songs.first.title).to eq song_title
      end
    end
    
    context "when song already exists" do
      let(:song) { create :song }

      before do
        user.add_song_to_repertoire song.title, song.artist.name
      end

      it "should not duplicate artist or song" do
        expect(Artist.all.count).to eq 1
        expect(Song.all.count).to eq 1
      end

      it "should add song to repertoire" do
        expect(user.songs).to eq [song]
      end
    end

    context "when song is already in user's repertoire" do
      let(:song) { create :song }

      before do
        user.songs << song
        user.add_song_to_repertoire song.title, song.artist.name
      end

      it "should not duplicate artist or song" do
        expect(Artist.all.count).to eq 1
        expect(Song.all.count).to eq 1
      end

      it "should not duplicate song in repertoire" do
        expect(user.songs.length).to eq 1
      end
    end
  end

  describe '#username' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should ensure_length_of(:username).is_at_least(1).is_at_most(50) }

    it { should allow_value('A').for(:username) }
    it { should allow_value('Aa1-').for(:username) }
    it { should allow_value('first-last').for(:username) }
    it { should allow_value('FirstLast123').for(:username) }

    it { should_not allow_value('first_last').for(:username) }
    it { should_not allow_value('first.last').for(:username) }
    it { should_not allow_value('first/last').for(:username) }
  end
end
