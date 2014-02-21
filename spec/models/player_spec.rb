# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  team       :integer
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  turn_order :integer
#  start_turn :integer
#

require 'spec_helper'

describe Player do
	let(:game) {FactoryGirl.create(:game)}
	let!(:player) {FactoryGirl.create(:player, game: game)}

	subject {player}

	it {should respond_to(:name)}
	it {should respond_to(:team)}
	it {should respond_to(:turn_order)}
	it {should respond_to(:start_turn)}

	it {should respond_to(:game)}
	it {should respond_to(:score_card)}

	it {should be_valid}

	describe "Associations" do
		#let!(:scorecard) {FactoryGirl.create(:score_card, player: player)}
		it "should belong to a game" do
			player.game.should be game
		end

		it "have a scorecard" do
			player.score_card.total.should be 0
		end
	end

	describe "Call Backs: " do
		it "should create a scorecard when saved" do
			player.score_card.should_not be_nil
		end
	end

	describe "Validations" do
		describe "should validate the presence of a game" do
			before {player.game = nil}
			it {should_not be_valid}
		end

		describe "should validate the presence of a name" do
			before {player.name = nil}
			it {should_not be_valid}
		end

		describe "should validate the presence of a team" do
			before {player.team = nil}
			it {should_not be_valid}
		end

		describe "should validate the presence of a turn_order" do

			before {player.turn_order = nil}
			xit {should_not be_valid}
		end

		describe "should validate the presence of a start_turn" do
			before {player.start_turn = nil}
			xit {should_not be_valid}
		end
	end

end
