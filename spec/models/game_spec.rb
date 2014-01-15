# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  date       :date
#  start_time :time
#  end_time   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Game do
	let(:game) {FactoryGirl.create(:game)}

	subject {game}

	it {should respond_to(:start_time)}
	it {should respond_to(:end_time)}
	it {should respond_to(:date)}

	it {should respond_to(:players)}
	it {should respond_to(:scorecards)}

	it {should be_valid}

	describe "Relationships" do
		let(:player1) {FactoryGirl.create(:player, game: game)}
		let!(:scorecard1) {FactoryGirl.create(:scorecard, player: player1)}

		let(:player2) {FactoryGirl.create(:player, game: game)}
		let!(:scorecard2) {FactoryGirl.create(:scorecard, player: player2)}

		it "should have many players" do
			game.players[0].name.should match player1.name
			game.players[1].name.should match player2.name
		end

		it "should have many scorecards" do
			game.scorecards[0].should match player1.scorecard
			game.scorecards[1].should match player2.scorecard
		end
	end

	describe "Validations" do
		it "should validate the presence of date" do
			game.date = nil
			it {should_not be_valid}
		end

		it "should validate the presence of start_time" do
			game.start_time = nil
			it {should_not be_valid}
		end
	end
end
