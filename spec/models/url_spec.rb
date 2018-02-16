require 'rails_helper'

RSpec.describe Url, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:route) }
    it { should validate_uniqueness_of(:route) }
    it { should validate_presence_of(:path) }

    context "custom validations" do
      context "non valid route" do
        it "throws invaild message" do
          url = build(:url, route: "abcd", path: "abcd")
          url.validate

          message = I18n.t("activerecord.errors.url.route.invalid_url")
          expect(url.errors.messages[:route]).to include message
        end
      end
    end
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

    it "returns self" do
      url = build(:url, route: "http://www.example.com/")

      expect(url.create_path).to eq url
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

  context "when Decorated" do
    let(:url) { create(:url, :with_path).decorate }

    describe "Display Constiants" do
      it { expect(url.class::ROUTE_LENGTH).to eq 37  }
      it { expect(url.class::ROUTE_TAG).to eq "..."  }
      it {
        limit = url.class::ROUTE_LENGTH + url.class::ROUTE_TAG.length
        expect(url.class::ROUTE_LENGTH_LIMIT).to eq limit
      }
    end

    describe "#created_at" do
      it "returns date formated in day(num) month(abbreviated) year(full_num)" do
        created_at = url.object.created_at.strftime("%d %b, %Y")

        expect(url.created_at).to eq created_at
      end
    end

    describe "#display_route" do
      context "if over length limit" do
        it "returns route with a limited length" do
          route = "http://example.com/foo/bar/bazzz/foo/bazz_1/quxxxx_13450/foo"
          url = build(:url, route: route)
          url.create_path.save
          url = url.decorate

          expect(url.display_route.length).to eq 40
          expect(url.display_route).to include "..."
        end
      end

      context "if NOT over length limit" do
        it "returns route" do
          url = create(:url, :with_path).decorate

          expect(url.display_route.length).to be < 40
          expect(url.display_route).not_to include "..."
        end
      end
    end
  end
end
