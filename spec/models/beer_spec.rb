require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:test_brewery) { Brewery.new name: "test", year: 2000 }
  let(:test_style) { Style.new name: "Tasty", description: "Awesome taste" }


  describe "with proper information" do
    it "has name, style and brewery set correctly" do
      beer = Beer.new name: "Test beer", style: test_style, brewery: test_brewery

      expect(beer.name).to eq("Test beer")
      expect(beer.style.name).to eq("Tasty")
      expect(beer.brewery.name).to eq("test")
    end

    it "is saved" do
      beer = Beer.create name: "Test beer", style: test_style, brewery: test_brewery

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "is not saved with" do
    it "missing name" do
      beer = Beer.create style: test_style, brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "empty name" do
      beer = Beer.create name: "", style: test_style, brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "missing brewery" do
      beer = Beer.create name: "Test beer", style: test_style

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "missing style" do
      beer = Beer.create name: "Test beer", brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
