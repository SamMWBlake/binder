feature "Chipotle" do
  ['burrito', 'burritos', 'tacos'].each do |path|
    scenario "follow /#{path} to Chipotle ordering site" do
      visit "/#{path}"
      expect(current_url).to eq "https://order.chipotle.com/"
    end
  end
end
