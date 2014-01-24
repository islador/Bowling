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
			
			expect(assigns(:score)).to be 10
			expect(assigns(:score)).to_not be 2
		end

		it "should return the correct total for a spare" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 5
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 2, :score => 5
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 5

			expect(assigns(:total)).to be 20
		end

		it "should return the correct total for a strike" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 5
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 4, :score => 5

			expect(assigns(:total)).to be 30
		end

		it "should return the corect total for a string of strikes" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 10
			expect(assigns(:total)).to be 30

			xhr :post, :add_score, :player_id => player2.id, :throw_id => 5, :score => 10
			expect(assigns(:total)).to be 60
		end

		it "should return a total of 300 for a perfect game" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 5, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 7, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 9, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 11, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 13, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 15, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 17, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 19, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 20, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 21, :score => 10

			expect(assigns(:total)).to be 300
		end

		it "should correctly total a strike followed by a spare" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 0
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 4, :score => 10

			expect(assigns(:total)).to be 30
		end

		it "should correctly total a strike followed by a spare and then a strike" do
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 1, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 3, :score => 0
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 4, :score => 10
			xhr :post, :add_score, :player_id => player2.id, :throw_id => 5, :score => 10

			expect(assigns(:total)).to be 50
		end
	end
end