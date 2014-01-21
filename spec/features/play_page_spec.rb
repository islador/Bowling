require 'spec_helper'

describe "Play Game Page > " do
	subject {page}

	let(:game) {FactoryGirl.create(:game)}

	describe "JavaScript" do
		before(:each) do
			visit games_new_path
		end
		it "Play page should have a game number display.", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			click_button 'Play'

			should have_selector('h2', text: "Game Number: 1")
		end

		it "Play page should have data-game-id with the current game id.", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			click_button 'Play'

			should have_selector("div.game_id[data-game-id='1']")
		end

		it "Play page should have one scorecard for each player", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			should have_selector("div.scorecard[data-player-id='1']")
			should have_selector("div.scorecard[data-player-id='2']")
		end

		it "in the event of a strike, the second score select for that frame should not be visible.", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			select "10", :from => "score_select_1_p1"

			should_not have_selector('#score_select_2_p1')
		end

		it "should calculate totals properly", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			select "10", :from => "score_select_1_p1"

			should have_selector('#total_score_p1', text: "10")

			select "10", :from => "score_select_3_p1"
			should have_selector('#total_score_p1', text: "30")

			select "10", :from => "score_select_5_p1"
			should have_selector('#total_score_p1', text: "60")
		end
	end
end