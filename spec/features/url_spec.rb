require 'rails_helper'

RSpec.feature Url, type: :feature do
  feature "url creation" do
    it "allows a url to be created" do
      visit(root_path)

      click_link(I18n.t("urls.index.links.new"))
      fill_form_and_submit(:url, :new, route: "http://www.example.com/")

      expect(page).to have_text "www.example.com"
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
