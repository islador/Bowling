require 'spec_helper'

describe "Load Page > " do
	subject {page}

	before(:each) do
		visit games_load_path
	end

	it "should have a text field called game_id" do
		should have_selector('input#game_id')
	end

	it "should have a button called 'Load'" do
		should have_selector('button#load', text: 'Load')
	end

	describe "Javascript > " do

		it "clicking the load button with a value other then an int should throw an error", js: true do
			visit games_new_path

			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			visit games_load_path
			fill_in 'game_id', :with => 'meow'
			click_button 'Load'
			should have_selector('#not_valid', text: 'Game not valid')
			should have_selector('Button#try_again', text: 'Try Again')
		end

		it "clicking the load button with a value that does not return a game should throw an error", js: true do
			visit games_new_path

			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			visit games_load_path
			fill_in 'game_id', :with => '22'
			click_button 'Load'
			should have_selector('#not_found', text: 'Game not found')
			should have_selector('Button#try_again', text: 'Try Again')
		end

		it "clicking the load button with a value matching an existing game should yield that game's page", js: true do
			visit games_new_path

			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			visit games_load_path
			fill_in 'game_id', :with => '1'
			click_button 'Load'
			should have_selector('#game_id', text: 'Game Number: 1')
		end
	end
end