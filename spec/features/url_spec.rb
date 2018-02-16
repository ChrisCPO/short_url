require 'rails_helper'

RSpec.feature Url, type: :feature do
  feature "url creation" do
    it "allows a url to be created" do
      visit(root_path)

      click_button(I18n.t("urls.index.links.new"))
      fill_form_and_submit(:url, :new, route: "http://www.example.com/")

      expect(page).to have_text "www.example.com"
      expect(page).to have_text root_path + "u/"
    end

    context "shows errors" do
      context "duplicate" do
        it "shows duplicate error" do
          url = create(:url, :with_path)
          visit(root_path)

          click_button(I18n.t("urls.index.links.new"))
          fill_form_and_submit(:url, :new, route: url.route)

          expect(page).to have_text I18n.t("errors.messages.taken")
        end
      end

      context "not a valid url" do
        it "shows nonvalid error" do
          visit(root_path)

          click_button(I18n.t("urls.index.links.new"))
          fill_form_and_submit(:url, :new, route: "foobar")

          message = I18n.t("activerecord.errors.url.route.invalid_url")
          expect(page).to have_text message
        end
      end
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
