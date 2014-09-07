describe Song do
  include_examples "alphabetical sort", :song, :title
  include_examples "autocompletable",   :song, :title

  it { should belong_to(:artist) }

  describe '#to_autocompletable' do
    subject { create :song }

    it "should return the title of the song and name of the artist" do
      expect(subject.to_autocompletable).to eq title: subject.title, artist: subject.artist.name
    end
  end
end
