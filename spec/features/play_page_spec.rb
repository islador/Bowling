require 'spec_helper'

describe "Play Game Page > " do
	subject {page}

	let(:game) {FactoryGirl.create(:game)}

	describe "JavaScript" do
		before(:each) do
			visit games_new_path
		end
		it "fill out name, select team 1 and click 'Add Player' should populate team 1 roster", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'

			#should have_selector("td[data-player-team='1']")
			click_button 'Play'

			should have_selector('h2', text: "Game Number: 1")
		end
	end

	#it "should have a game ID in the top center" do
		#get :play, :game_id => game.id

	#	should have_selector('h2', text: "Game Number ")
	#end


end