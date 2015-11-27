require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

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

    # it "can leave only one review" do
    #   visit '/restaurants'
    #   click_link 'Review KFC'
    #   fill_in "Thoughts", with: "so so"
    #   select '3', from: 'Rating'
    #   click_button 'Leave Review'
    #
    #   visit '/restaurants'
    #   click_link 'Review KFC'
    #   expect(page).to have_content("Can't add more than one review")
    # end

  end

end
