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
#

require 'spec_helper'

describe Player do
	let(:game) {FactoryGirl.create(:game)}
	let (:player) {FactoryGirl.create(:player, game: game)}

	subject {player}

	it {should respond_to(:name)}
	it {should respond_to(:team)}

	it {should respond_to(:game)}
	it {should respond_to(:score_card)}

	it {should be_valid}

	describe "Relationships" do
		let!(:scorecard) {FactoryGirl.create(:score_card, player: player)}
		it "should belong to a game" do
			player.game.should be game
		end

		it "have a scorecard" do
			player.score_card.total.should be 0
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
	end

end
