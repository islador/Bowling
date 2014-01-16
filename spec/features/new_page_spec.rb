require 'spec_helper'

describe "New Game Page > " do

	subject {page}

	before do
		visit games_new_path
	end

	it "should have a big play button at the bottom" do
		should have_selector('button#play', text: "Play")
	end

	describe "Player Add Form > " do
		it "should have div add_player" do
			should have_selector('div#add_player')
		end

		it "should have a data element displaying the game id" do
			should have_selector("div#add_player[data-game-id]")
		end

		it "should have a text field for name" do
			should have_selector('input#player_name')
		end

		it "should have a radio for team" do
			should have_selector('input#team_1')
			should have_selector('input#team_2')
		end

		it "should have a button to add a player" do
			should have_selector('button#add_player_submit', text: 'Add Player')
		end

		describe "JavaScript" do
			it "fill out name, select team 1 and click 'Add Player' should populate team 1 roster", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'

				should have_selector("td[data-player-team='1']")
			end

			it "fill out name, select team 2 and click 'Add Player', should populate team 2 roster", js: true do
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'

				should have_selector("td[data-player-team='2']")
			end

			it "clicking the submit button should blank out the player_name field", js: true do
				fill_in 'player_name', :with => 'Alex'
				choose 'team_1'
				click_button 'Add Player'

				should have_selector("td[data-player-team='1']")
				should have_selector("input#player_name", text: '')
			end
		end
	end

	describe "Team Display Tables > " do
		it "should have a div 'team_1_display_table'" do
			should have_selector('div#team_1_display_table')
		end
		it "should have a div 'team_2_display_table'" do
			should have_selector('div#team_2_display_table')
		end

		it "should have a table called 'team_1_table'" do
			should have_selector('table#team_1_table')
		end
		it "should have a table called 'team_2_table'" do
			should have_selector('table#team_2_table')
		end

		describe "Team Table Head > " do
			it "should have a th with content 'Team 1'" do
				should have_selector('th', text: 'Team 1')
			end

			it "should have a th with content 'Team 2'" do
				should have_selector('th', text: 'Team 2')
			end
		end
	end
end