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

	it {should be_valid}

	describe "Relationships" do
		let(:player1) {FactoryGirl.create(:player, game: game)}
		let!(:scorecard1) {FactoryGirl.create(:score_card, player: player1)}

		let(:player2) {FactoryGirl.create(:player, game: game)}
		let!(:scorecard2) {FactoryGirl.create(:score_card, player: player2)}

		it "should have many players" do
			game.players[0].name.should match player1.name
			game.players[1].name.should match player2.name
		end
	end

	describe "Validations" do
		describe "should validate the presence of date" do
			before {game.date = nil}
			it {should_not be_valid}
		end

		describe "should validate the presence of start_time" do
			before{game.start_time = nil}
			it {should_not be_valid}
		end
	end
end
