require 'rails_helper'

feature 'reviewing' do
  before do
    signup(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest' )
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  context 'leave reviews' do
    it "allows user to write review" do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'

      expect(current_path).to eq('/restaurants')
      expect(page).to have_content('so so')
    end

    scenario "displays average ratings for all reviews" do
      leave_review('So so', '3')
      leave_review('Great', '5')
      expect(page).to have_content('Average rating: 4')
    end

    def leave_review(thoughts, ratings)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: thoughts
      select rating, from: 'Rating'
      click_button 'Leave Review'
    end

  end

end
