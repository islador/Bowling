require 'spec_helper'

describe PlayersController do
	
	describe "Add Score" do
		let!(:game) {FactoryGirl.create(:game)}
		let!(:player1) {FactoryGirl.create(:player, game: game)}
		let!(:player2) {FactoryGirl.create(:player, game: game)}

		it "should add a score to the player's score card" do

			xhr :post, :add_score, :player_id => player1.id, :throw_id => 1, :score => 10
			
			expect(assigns(:score)). to be 10
		end

		it "should return the correct score" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 2, :score => 2
			expect(assigns(:score)).to be 2
			expect(assigns(:score)).to_not be 10

			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 2
			xhr :post, :add_score, :player_id => player1.id, :throw_id => 2, :score => 10
			
			expect(assigns(:score)). to be 10
			expect(assigns(:score)).to_not be 2
		end
	end
end