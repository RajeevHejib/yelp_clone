require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      # visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it "can not delete a restaurant not created by the user" do
      Restaurant.create name: "KFC"
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content("You can't delete as you didnt create this restaurant")
    end

    it "can not edit a restaurant not created by the user" do
      Restaurant.create name: "KFC"
      visit '/restaurants'
      click_link 'Edit KFC'
      expect(page).to have_content("You can't edit as you didnt create this restaurant")
    end



  end



end
