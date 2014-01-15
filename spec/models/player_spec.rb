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
	it {should respond_to(:scorecard)}

	it {should be_valid}

	describe "Relationships" do
		let(:scorecard) {FactoryGirl.create(:scorecard, player: player)}
		it "should belong to a game" do
			player.game.should be game
		end

		it "have a scorecard" do
			player.scorecard.should be scorecard
		end
	end

	describe "Validations" do
		it "should validate the presence of a game" do
			player.game = nil
			it {should_not be_valid}
		end

		it "should validate the presence of a name" do
			player.name = nil
			it {should_not be_valid}
		end

		it "should validate the presence of a team" do
			player.team = nil
			it {should_not be_valid}
		end
	end

end
