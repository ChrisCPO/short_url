require 'rails_helper'

RSpec.feature Url, type: :feature do
  feature "url creation" do
    it "allows a url to be created" do
      visit(root_path)

      fill_in "url_route", with: "http://www.example.com/"
      click_button I18n.t("helpers.submit.url.create")

      expect(page).to have_button t("helpers.submit.url.create")
      url = Url.first.decorate
      expect(page).to have_text "www.example.com"
      expect(page).to have_text url.display_route
      expect(page).to have_text root_path + "u/"
    end
  end

  feature "url deletion" do
    it "allows a url to be created" do
      url = create(:url, :with_path).decorate
      visit root_path

      click_button("Delete")

      expect(page).not_to have_text url.route
    end
  end
end
