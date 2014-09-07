shared_examples "autocompletable" do |completable, completable_field|
  describe '#starts_with' do
    let!(:ab) { create completable, completable_field => "ab" }
    let!(:ac) { create completable, completable_field => "Ac" }
    let!(:bc) { create completable, completable_field => "bc" }

    it "should return only those starting with the specified prefix" do
      expect(completable.to_s.classify.constantize.starts_with("a") ).to eq [ab, ac]
    end
  end
end

shared_examples "GET #index returns all or matching" do |completable, completable_field, fields_of_interest|
  describe 'GET #index' do
    let!(:a) { create completable, completable_field => "a" }
    let!(:b) { create completable, completable_field => "b" }

    context "when prefix filter is provided" do
      it "should return matching" do
        get :index, starts_with: "a"
        expect(response.body).to be_json_eql [a.to_autocompletable].to_json
      end
    end

    context "when no prefix is provided" do
      it "should return all" do
        get :index
        expect(response.body).to be_json_eql [a.to_autocompletable, b.to_autocompletable].to_json
      end
    end
  end
end
