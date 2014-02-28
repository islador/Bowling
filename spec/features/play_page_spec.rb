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
			click_button 'Play'

			select "10", :from => "score_select_1_p1"

			should have_selector('#total_score_p1', text: "10")

			select "10", :from => "score_select_3_p1"
			should have_selector('#total_score_p1', text: "30")

			select "10", :from => "score_select_5_p1"
			should have_selector('#total_score_p1', text: "60")
		end

		it "should remove the select after a score is selected from it and replace it with a hard text score", js: true do

			fill_in 'player_name', :with => 'Jack'
			choose 'team_1'
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

		describe "Turn Enforcement > " do
			it "Should have the number of players in the div.game_id element as data-player-count", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				should have_selector("div.game_id[data-player-count='2']", )
			end

			it "Each div.bigbox should have the id turn_number_X and a data attribute 'data-turn-number=X'", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_1_p2"

				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_3_p2"
				
				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_5_p2"

				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_7_p2"

				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_9_p2"

				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_11_p2"

				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_13_p2"

				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_15_p2"

				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_17_p2"

				select "0", :from => "score_select_19_p1"
				select "0", :from => "score_select_20_p1"

				select "0", :from => "score_select_19_p2"
				select "0", :from => "score_select_20_p2"

				within '#score_card_0' do
					should have_selector("div#turn_number_0[data-turn-number='0']")
					should have_selector("div#turn_number_2[data-turn-number='2']")
					should have_selector("div#turn_number_4[data-turn-number='4']")
					should have_selector("div#turn_number_6[data-turn-number='6']")
					should have_selector("div#turn_number_8[data-turn-number='8']")
					should have_selector("div#turn_number_10[data-turn-number='10']")
					should have_selector("div#turn_number_12[data-turn-number='12']")
					should have_selector("div#turn_number_14[data-turn-number='14']")
					should have_selector("div#turn_number_16[data-turn-number='16']")
					should have_selector("div#turn_number_18[data-turn-number='18']")
				end

				within '#score_card_1' do
					should have_selector("div#turn_number_1[data-turn-number='1']")
					should have_selector("div#turn_number_3[data-turn-number='3']")
					should have_selector("div#turn_number_5[data-turn-number='5']")
					should have_selector("div#turn_number_7[data-turn-number='7']")
					should have_selector("div#turn_number_9[data-turn-number='9']")
					should have_selector("div#turn_number_11[data-turn-number='11']")
					should have_selector("div#turn_number_13[data-turn-number='13']")
					should have_selector("div#turn_number_15[data-turn-number='15']")
					should have_selector("div#turn_number_17[data-turn-number='17']")
					should have_selector("div#turn_number_19[data-turn-number='19']")
				end
			end

			it "The first player's first div.bigbox should have the id turn_number_0 and a data attribute 'data-turn-number=0'", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				within '#score_card_0' do
					should have_selector("div#turn_number_0[data-turn-number='0']")
				end
			end

			it "In a two player game the first player's tenth div.bigbox should have the id turn_number_18 and a data attribute 'data-turn-number=18'", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_1_p2"

				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_3_p2"

				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_5_p2"

				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_7_p2"

				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_9_p2"

				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_11_p2"

				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_13_p2"

				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_15_p2"

				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_17_p2"

				within '#score_card_0' do
					should have_selector("div#turn_number_18[data-turn-number='18']")
				end
			end

			it "In a two player game the second player's first div.bigbox should have the id turn_number_1 and a data attribute 'data-turn-number=1'", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_1_p2"

				within '#score_card_1' do
					should have_selector("div#turn_number_1[data-turn-number='1']")
				end
			end

			it "In a two player game the second player's tenth div.bigbox should have the id turn_number_19 and a data attribute 'data-turn-number=19'", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				select "10", :from => "score_select_1_p1"
				select "10", :from => "score_select_1_p2"

				select "10", :from => "score_select_3_p1"
				select "10", :from => "score_select_3_p2"

				select "10", :from => "score_select_5_p1"
				select "10", :from => "score_select_5_p2"

				select "10", :from => "score_select_7_p1"
				select "10", :from => "score_select_7_p2"

				select "10", :from => "score_select_9_p1"
				select "10", :from => "score_select_9_p2"

				select "10", :from => "score_select_11_p1"
				select "10", :from => "score_select_11_p2"

				select "10", :from => "score_select_13_p1"
				select "10", :from => "score_select_13_p2"

				select "10", :from => "score_select_15_p1"
				select "10", :from => "score_select_15_p2"

				select "10", :from => "score_select_17_p1"
				select "10", :from => "score_select_17_p2"

				select "10", :from => "score_select_19_p1"
				select "10", :from => "score_select_20_p1"
				select "10", :from => "score_select_21_p1"

				within '#score_card_1' do
					should have_selector("div#turn_number_19[data-turn-number='19']")
				end
			end

			it "Should display the first turn frame on a new game and wait for player input", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				should have_selector('#turn_number_0')
				should_not have_selector('#turn_number_1')
			end

			it "Should display the first turn frame's first select but not the second on a new game and wait for player input", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
				click_button 'Add Player'
				fill_in 'player_name', :with => 'Jill'
				choose 'team_2'
				click_button 'Add Player'
				click_button 'Play'

				should have_selector('#score_select_1_p1')
				should_not have_selector('#score_select_2_p1')
			end
		end

		describe "Score Removal > " do

			it "should remove all illegal scores from the next select in a frame", js: true do
				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
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

		describe "Last Frame > " do
			it "should not hide the 20th select after a strike in the 19th", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
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
				select "0", :from => "score_select_20_p1"
				should have_selector('#score_select_21_p1')
			end

			it "should not hide the 21st select if a spare is thrown in the 10th frame", js: true do

				fill_in 'player_name', :with => 'Jack'
				choose 'team_1'
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
				
				#select "10", :from => "score_select_20_p1"
				#should have_selector('select#score_select_21_p1')
			end
		end
	end
end