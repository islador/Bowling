require 'spec_helper'

describe ScoreCard do
	let(:player) {FactoryGirl.create(:player)}
	let(:scorcard) {FactoryGirl.create(:scorecard, player: player)}

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
	it {should respond_to(:scores)}
	it {should respond_to(:total)}
	
	it {should respond_to(:player)}

	it {should be_valid}

	describe "Relationships" do
		it "should belong to a player." do
			scorecard.player.should be player
		end
	end

	describe "Validations" do
		it "should validate the presence of a player" do
			scorecard.player_id = nil
			it {should_not be_valid}
		end
	end
end