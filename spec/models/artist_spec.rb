describe Artist do
  include_examples "alphabetical sort", :artist, :name
  include_examples "autocompletable",   :artist, :name

  it { should have_many(:songs) }

  describe '#to_autocompletable' do
    subject { create :artist }

    it "should return the name of the artist" do
      expect(subject.to_autocompletable).to eq name: subject.name
    end
  end
end
