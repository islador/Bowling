require 'spec_helper'

describe ScoreCard do
	let(:player) {FactoryGirl.create(:player)}
	let(:scorecard) {FactoryGirl.create(:score_card, player: player)}

	subject {scorecard}

	
	it {should respond_to(:throw1)}
	it {should respond_to(:throw2)}
	it {should respond_to(:throw3)}
	it {should respond_to(:throw4)}
	it {should respond_to(:throw5)}
	it {should respond_to(:throw6)}
	it {should respond_to(:throw7)}
	it {should respond_to(:throw8)}
	it {should respond_to(:throw9)}
	it {should respond_to(:throw10)}
	it {should respond_to(:throw11)}
	it {should respond_to(:throw12)}
	it {should respond_to(:throw13)}
	it {should respond_to(:throw14)}
	it {should respond_to(:throw15)}
	it {should respond_to(:throw16)}
	it {should respond_to(:throw17)}
	it {should respond_to(:throw18)}
	it {should respond_to(:throw19)}
	it {should respond_to(:throw20)}
	it {should respond_to(:throw21)}
	it {should respond_to(:total)}

	it {should respond_to(:frame_1)}
	it {should respond_to(:frame_2)}
	it {should respond_to(:frame_3)}
	it {should respond_to(:frame_4)}
	it {should respond_to(:frame_5)}
	it {should respond_to(:frame_6)}
	it {should respond_to(:frame_7)}
	it {should respond_to(:frame_8)}
	it {should respond_to(:frame_9)}
	it {should respond_to(:frame_10)}

	it {should respond_to(:player)}

	it {should be_valid}

	describe "Associations" do
		it "should belong to a player." do
			scorecard.player.should be player
		end
	end

	describe "Call Backs: " do
		it "The scorecard should have a total of 0" do
			scorecard.total.should be 0
		end

		it "All frames should have a value of 0" do
			scorecard.frame_1.should be 0
			scorecard.frame_2.should be 0
			scorecard.frame_3.should be 0
			scorecard.frame_4.should be 0
			scorecard.frame_5.should be 0
			scorecard.frame_6.should be 0
			scorecard.frame_7.should be 0
			scorecard.frame_8.should be 0
			scorecard.frame_9.should be 0
			scorecard.frame_10.should be 0
		end
	end

	describe "Validations" do
		describe "should validate the presence of a player" do
			before {scorecard.player_id = nil}
			it {should_not be_valid}
		end
	end
end