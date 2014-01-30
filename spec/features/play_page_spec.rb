require 'spec_helper'

describe "Play Game Page > " do
	subject {page}

	let(:game) {FactoryGirl.create(:game)}

	describe "JavaScript > " do
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

		it "No selects other then select 21 should be hidden on a throw of less then a strike", js: true do
			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
			click_button 'Add Player'
			fill_in 'player_name', :with => 'Jill'
			choose 'team_2'
			click_button 'Add Player'
			click_button 'Play'

			select "5", :from => "score_select_1_p1"
			should have_selector('#score_select_2_p1')

			select "5", :from => "score_select_2_p1"
			should have_selector('#score_select_3_p1')

			select "7", :from => "score_select_6_p1"
			should have_selector('#score_select_7_p1')
			should have_selector('#score_select_8_p1')
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

		describe "Score Removal > " do

			it "should remove all illegal scores from the next select in a frame", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "5", :from => "score_select_1_p1"

				#Should remove all illegal scores from the next select in the frame
				within '#score_select_2_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")

					should_not have_css("option[value='6']")
					should_not have_css("option[value='7']")
					should_not have_css("option[value='8']")
					should_not have_css("option[value='9']")
					should_not have_css("option[value='10']")
				end

				select "3", :from => "score_select_2_p1"

				#Should not alter scores in the next frame's select
				within '#score_select_3_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")
					should have_css("option[value='6']")
					should have_css("option[value='7']")
					should have_css("option[value='8']")
					should have_css("option[value='9']")
					should have_css("option[value='10']")
				end

				select "0", :from => "score_select_3_p1"

				#Should have all values in the next select within the frame
				within '#score_select_4_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")
					should have_css("option[value='6']")
					should have_css("option[value='7']")
					should have_css("option[value='8']")
					should have_css("option[value='9']")
					should have_css("option[value='10']")
				end
			end

			it "should remove illegal scores from throw 20 if a strike is not scored in throw 19", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_17_p1"

				select "5", :from => "score_select_19_p1"

				#Should have all values in the next select within the frame
				within '#score_select_20_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")

					should_not have_css("option[value='6']")
					should_not have_css("option[value='7']")
					should_not have_css("option[value='8']")
					should_not have_css("option[value='9']")
					should_not have_css("option[value='10']")
				end
			end

			it "should not remove scores from throw 20 if a strike is scored in throw 19", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_17_p1"

				select "10", :from => "score_select_19_p1"

				#Should have all values in the next select within the frame
				within '#score_select_20_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")
					should have_css("option[value='6']")
					should have_css("option[value='7']")
					should have_css("option[value='8']")
					should have_css("option[value='9']")
					should have_css("option[value='10']")
				end
			end

			it "should not remove scores from throw 21 if a strike is scored in throw 20", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_19_p1"
				select "10", :from => "score_select_20_p1"

				#Should have all values in the next select within the frame
				within '#score_select_21_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")
					should have_css("option[value='6']")
					should have_css("option[value='7']")
					should have_css("option[value='8']")
					should have_css("option[value='9']")
					should have_css("option[value='10']")
				end
			end

			it "should not remove scores from throw 21 if a spare is scored in throw 19 and 20", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_17_p1"
				select "5", :from => "score_select_19_p1"
				select "5", :from => "score_select_20_p1"

				#Should have all values in the next select within the frame
				within '#score_select_21_p1' do
					should have_css("option[value='0']")
					should have_css("option[value='1']")
					should have_css("option[value='2']")
					should have_css("option[value='3']")
					should have_css("option[value='4']")
					should have_css("option[value='5']")
					should have_css("option[value='6']")
					should have_css("option[value='7']")
					should have_css("option[value='8']")
					should have_css("option[value='9']")
					should have_css("option[value='10']")
				end
			end
		end
		
		it "should remove the select after a score is selected from it and replace it with a hard text score", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				should_not have_selector('select#score_select_1_p1')
				should have_selector('#score_select_1_p1', text: "10")
				
				select "10", :from => "score_select_3_p1"
				should_not have_selector('select#score_select_3_p1')
				should have_selector('#score_select_3_p1', text: "10")
				
				select "10", :from => "score_select_5_p1"
				should_not have_selector('select#score_select_5_p1')
				should have_selector('#score_select_5_p1', text: "10")

				select "10", :from => "score_select_7_p1"
				should_not have_selector('select#score_select_7_p1')
				should have_selector('#score_select_7_p1', text: "10")

				select "10", :from => "score_select_9_p1"
				should_not have_selector('select#score_select_9_p1')
				should have_selector('#score_select_9_p1', text: "10")

				select "10", :from => "score_select_11_p1"
				should_not have_selector('select#score_select_11_p1')
				should have_selector('#score_select_11_p1', text: "10")

				select "10", :from => "score_select_13_p1"
				should_not have_selector('select#score_select_13_p1')
				should have_selector('#score_select_13_p1', text: "10")

				select "5", :from => "score_select_15_p1"
				should_not have_selector('select#score_select_15_p1')
				should have_selector('#score_select_15_p1', text: "5")

				select "4", :from => "score_select_16_p1"
				should_not have_selector('select#score_select_16_p1')
				should have_selector('#score_select_16_p1', text: "4")

				select "10", :from => "score_select_17_p1"
				should_not have_selector('select#score_select_17_p1')
				should have_selector('#score_select_17_p1', text: "10")

				select "0", :from => "score_select_19_p1"
				should_not have_selector('select#score_select_19_p1')
				should have_selector('#score_select_19_p1', text: "0")

				select "10", :from => "score_select_20_p1"
				should_not have_selector('select#score_select_20_p1')
				should have_selector('#score_select_20_p1', text: "10")

				select "10", :from => "score_select_21_p1"
				should_not have_selector('select#score_select_21_p1')
				should have_selector('#score_select_21_p1', text: "10")
			end

		describe "Last Frame > " do
			it "should not hide the 20th select after a strike in the 19th", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "5", :from => "score_select_15_p1"
				select "4", :from => "score_select_16_p1"
				select "10", :from => "score_select_17_p1"
				should_not have_selector('#score_select_18_p1')

				select "10", :from => "score_select_19_p1"
				should have_selector('#score_select_20_p1')
			end

			it "should not hide the 21st select if a strike is thrown in the 10th frame", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "5", :from => "score_select_15_p1"
				select "4", :from => "score_select_16_p1"
				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_19_p1"
				should have_selector('#score_select_21_p1')
			end

			it "should not hide the 21st select if a spare is thrown in the 10th frame", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "5", :from => "score_select_15_p1"
				select "4", :from => "score_select_16_p1"
				select "10", :from => "score_select_17_p1"
				select "0", :from => "score_select_19_p1"
				select "10", :from => "score_select_20_p1"
				should have_selector('#score_select_21_p1')
			end

			it "should hide the 21st select if a strike or spare is not thrown in the 10th frame", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'
				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "5", :from => "score_select_15_p1"
				select "4", :from => "score_select_16_p1"
				select "10", :from => "score_select_17_p1"
				select "0", :from => "score_select_19_p1"
				select "0", :from => "score_select_20_p1"
				should_not have_selector('#score_select_21_p1')
			end
		end

		describe "Loaded Game > " do
			it "should display existing scores instead of select drop downs", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "5", :from => "score_select_1_p1"
				select "5", :from => "score_select_2_p1"
				select "5", :from => "score_select_3_p1"
				select "5", :from => "score_select_4_p1"
				select "5", :from => "score_select_5_p1"
				select "5", :from => "score_select_6_p1"
				select "5", :from => "score_select_7_p1"
				select "5", :from => "score_select_8_p1"
				select "5", :from => "score_select_9_p1"
				select "5", :from => "score_select_10_p1"
				select "5", :from => "score_select_11_p1"
				select "5", :from => "score_select_12_p1"
				select "5", :from => "score_select_13_p1"
				select "5", :from => "score_select_14_p1"
				select "5", :from => "score_select_15_p1"
				select "5", :from => "score_select_16_p1"
				select "5", :from => "score_select_17_p1"
				select "5", :from => "score_select_18_p1"
				select "5", :from => "score_select_19_p1"
				select "5", :from => "score_select_20_p1"
				select "5", :from => "score_select_21_p1"

				visit games_load_path

				fill_in 'game_id', :with => '1'
				click_button 'Load'

				should_not have_selector('select#score_select_1_p1')
				should have_selector('#score_select_1_p1', text: "5")

				should_not have_selector('select#score_select_2_p1')
				should have_selector('#score_select_2_p1', text: "5")

				should_not have_selector('select#score_select_3_p1')
				should have_selector('#score_select_3_p1', text: "5")

				should_not have_selector('select#score_select_4_p1')
				should have_selector('#score_select_4_p1', text: "5")

				should_not have_selector('select#score_select_5_p1')
				should have_selector('#score_select_5_p1', text: "5")

				should_not have_selector('select#score_select_6_p1')
				should have_selector('#score_select_6_p1', text: "5")

				should_not have_selector('select#score_select_7_p1')
				should have_selector('#score_select_7_p1', text: "5")

				should_not have_selector('select#score_select_8_p1')
				should have_selector('#score_select_8_p1', text: "5")

				should_not have_selector('select#score_select_9_p1')
				should have_selector('#score_select_9_p1', text: "5")

				should_not have_selector('select#score_select_10_p1')
				should have_selector('#score_select_10_p1', text: "5")

				should_not have_selector('select#score_select_11_p1')
				should have_selector('#score_select_11_p1', text: "5")

				should_not have_selector('select#score_select_12_p1')
				should have_selector('#score_select_12_p1', text: "5")

				should_not have_selector('select#score_select_13_p1')
				should have_selector('#score_select_13_p1', text: "5")

				should_not have_selector('select#score_select_14_p1')
				should have_selector('#score_select_14_p1', text: "5")

				should_not have_selector('select#score_select_15_p1')
				should have_selector('#score_select_15_p1', text: "5")

				should_not have_selector('select#score_select_16_p1')
				should have_selector('#score_select_16_p1', text: "5")

				should_not have_selector('select#score_select_17_p1')
				should have_selector('#score_select_17_p1', text: "5")

				should_not have_selector('select#score_select_18_p1')
				should have_selector('#score_select_18_p1', text: "5")

				should_not have_selector('select#score_select_19_p1')
				should have_selector('#score_select_19_p1', text: "5")

				should_not have_selector('select#score_select_20_p1')
				should have_selector('#score_select_20_p1', text: "5")

				should_not have_selector('select#score_select_21_p1')
				should have_selector('#score_select_21_p1', text: "5")
			end

			it "should not display the second select in a frame after a strike unless it is frame 10", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"

				visit games_load_path

				fill_in 'game_id', :with => '1'
				click_button 'Load'

				should_not have_selector('select#score_select_1_p1')
				should have_selector('#score_select_1_p1', text: "10")

				should_not have_selector('select#score_select_2_p1')
				should have_selector('#score_select_2_p1', text: "")
			end

			it "should display the second select in frame 10 even if there is a strike in the first throw", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_19_p1"

				visit games_load_path

				fill_in 'game_id', :with => '1'
				click_button 'Load'

				should_not have_selector('select#score_select_19_p1')
				should have_selector('#score_select_19_p1', text: "10")

				should have_selector('select#score_select_20_p1')
				should have_selector('select#score_select_21_p1')
			end
		end
	end
end