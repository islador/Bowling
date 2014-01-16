require 'spec_helper'

describe "New Game Page > " do

	subject {page}

	before do
		visit games_new_path
	end

	describe "Player Add Form" do
		it "should have div add_player" do
			should have_selector('div#add_player')
		end

		it "should have a text field for name" do
			should have_selector('input#player_name')
		end

		it "should have a radio for team" do
			should have_selector('input#team_Team_1')
			should have_selector('input#team_Team_2')
		end

		it "should have a button to add a player" do
			should have_selector('button#add_player_submit', text: 'Add Player')
		end
	end
end