shared_examples "alphabetical sort" do |sortable, sortable_field|
  describe '#all' do
    let(:c) { create sortable, sortable_field => "c" }
    let(:a) { create sortable, sortable_field => "a" }
    let(:b) { create sortable, sortable_field => "B" }

    it "should return all in case-insensitive alphabetical order" do
      expect(sortable.to_s.classify.constantize.all ).to eq [a, b, c]
    end
  end
end
