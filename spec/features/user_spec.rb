require 'rails_helper'

feature "user", js: true do
  let!(:comment){ "q incidunt." }
  describe "add new user" do
    before do
      visit new_user_path
    end

    it "should save the new user" do
      expect(page).to have_selector('h1', text: 'New User')
      fill_in('user_comment', with: comment)
      expect{ click_button('Create User'); page.find('h1', text: "Users") }.to change{ User.count }.by(1)
      expect(page).to have_selector('.user_comment', text: comment )
    end
  end
end
