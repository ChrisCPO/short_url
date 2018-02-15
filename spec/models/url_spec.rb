require 'rails_helper'

RSpec.describe Url, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:route) }
    it { should validate_uniqueness_of(:route) }
    it { should validate_presence_of(:path) }
  end

  describe "Constants" do
    it { expect(Url::DEFAULT_PATH_LENGTH).to eq 5  }
  end

  describe "#new" do
    it "removes http:// from route before saving" do
      url = Url.new(route: "http://www.example.com/")

      expect(url.route).to eq "www.example.com/"
    end
  end

  describe "#create_path" do
    it "creates a unique short path from route" do
      url = build(:url, route: "http://www.example.com/")

      url.create_path
      url.save

      expect(url.path.present?).to eq true
      expect(url.path.length).to eq 10
    end
  end

  describe "#full_route" do
    it "returns route preceded with http://" do
      url = create(:url, :with_path)

      expect(url.full_route).to eq "http://" + url.route
    end
  end

  describe "#full_path" do
    it "returns local full path for url" do
      url = create(:url, :with_path)

      expect(url.full_path).to eq "/u/" + url.path
    end
  end
end
