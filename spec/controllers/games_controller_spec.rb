require 'spec_helper'

describe GamesController do
	

	describe "New" do
		it "should create a new game called games" do
			get :new
			expect(assigns(:game)).to_not be_nil
		end

		it "should create a players array for the new game" do
			get :new
			expect(assigns(:players)).to be_empty
		end

		it "should render the new page" do
			get :new
			expect(response).to render_template("new")
		end
	end

	describe "Add Player > " do
		let!(:game) {FactoryGirl.create(:game)}

		it "should create players based on the parameters it is sent" do
			xhr :post, :add_player, :game_id => 1, :name => "John", :team => 1

			expect(assigns(:player).name).to match game.players[-1].name
			expect(assigns(:player).team).to be game.players[-1].team
			expect(assigns(:player)).to_not be_nil
		end

		it "should create a variable of all players in the given game" do
			xhr :post, :add_player, :game_id => 1, :name => "John", :team => 1
			expect(assigns(:players).length).to be 1
		end

		describe "Turn Order Generation" do

			it "should create a variable called turn_order that contains the player's turn order" do
				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 1
				expect(assigns(:turn_order)).to_not be_nil
			end

			it "should assign the first player on team one to a turn order of 0 even if s/he is last to be added" do
				xhr :post, :add_player, :game_id => 1, :name => "J", :team => 2
				expect(assigns(:turn_order)).to be 1

				xhr :post, :add_player, :game_id => 1, :name => "Je", :team => 2
				expect(assigns(:turn_order)).to be 3

				xhr :post, :add_player, :game_id => 1, :name => "Jes", :team => 2
				expect(assigns(:turn_order)).to be 5

				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 1
				expect(assigns(:turn_order)).to be 0
			end

			it "should assign the first player on team two to a turn order of 1 even if s/he is last to be added" do
				xhr :post, :add_player, :game_id => 1, :name => "J", :team => 1
				expect(assigns(:turn_order)).to be 0

				xhr :post, :add_player, :game_id => 1, :name => "Je", :team => 1
				expect(assigns(:turn_order)).to be 2

				xhr :post, :add_player, :game_id => 1, :name => "Jes", :team => 1
				expect(assigns(:turn_order)).to be 4

				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 2
				expect(assigns(:turn_order)).to be 1
			end

			it "should create a variable called turn_order that contains the player's correct turn order" do
				#Team 2's first player is always the second player to go (binary counting)
				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 2
				expect(assigns(:player).turn_order).to be 1

				#Team 1's first player is always the first player to go (binary counting)
				xhr :post, :add_player, :game_id => 1, :name => "James", :team => 1
				expect(assigns(:turn_order)).to be 0

				#Team 1's second player is always the third player to go (binary counting)
				xhr :post, :add_player, :game_id => 1, :name => "Jeffrey", :team => 1
				expect(assigns(:turn_order)).to be 2

				#Team 1's third player is always the fifth person to go (binary counting)
				xhr :post, :add_player, :game_id => 1, :name => "Jesaray", :team => 1
				expect(assigns(:turn_order)).to be 4

				#Team 2's second player is always the fourth person to go (binary counting)
				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 2
				expect(assigns(:turn_order)).to be 3
			end
		end

		describe "Start Turn Generation > " do
			it "should create a variable called start_turn that is ten times the player's turn order" do
				xhr :post, :add_player, :game_id => 1, :name => "Jessica", :team => 2
				expect(assigns(:start_turn)).to be 10

				xhr :post, :add_player, :game_id => 1, :name => "Je", :team => 1
				expect(assigns(:start_turn)).to be 0

				xhr :post, :add_player, :game_id => 1, :name => "Jea", :team => 1
				expect(assigns(:start_turn)).to be 20

				xhr :post, :add_player, :game_id => 1, :name => "Jes", :team => 2
				expect(assigns(:start_turn)).to be 30
			end
		end
	end

	describe "Load" do

	end

	describe "Play" do
		let!(:game) {FactoryGirl.create(:game)}

		it "should retrieve a game based on the parameters it is sent" do
			xhr :get, :play, :game_id => 1
			expect(assigns(:game).id).to be 1
		end
	end

	describe "game_exists" do
		let!(:game) {FactoryGirl.create(:game)}

		it "should retrieve the game with an id matching the parameter it is sent" do
			xhr :get, :game_exists, :game_id => 1
			expect(assigns(:game).id).to be 1
		end

		it "should return a nil if there is no name matching the ID it is sent" do
			xhr :get, :game_exists, :game_id => 22
			expect(assigns(:game)).to be_nil
		end
	end
end