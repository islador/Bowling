require 'spec_helper'

describe GamesController do
	

	describe "New" do
		it "should create a new game called games" do
			#@time_now = Time.new(2014, 1, 15, 2, 2, 2, "-08:00")
			#Time.stub(:now).and_return(@time_now)

			#game = FactoryGirl.create(:game)

			get :new
			expect(assigns(:game)).to_not be_nil
			#be_a_new(Game)#.to be true #have_same_attributes_as(game)
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

	describe "Add Player" do
		let!(:game) {FactoryGirl.create(:game)}
		let!(:player1) {FactoryGirl.create(:player, game: game)}
		let!(:player2) {FactoryGirl.create(:player, game: game)}

		it "should create players based on the parameters it is sent" do
			xhr :post, :add_player, :game_id => 1, :name => "John", :team => 1

			expect(assigns(:player).name).to match game.players[-1].name
			expect(assigns(:player).team).to be game.players[-1].team
			expect(assigns(:player)).to_not be_nil
		end

		it "should create a variable of all players in the given game" do
			xhr :post, :add_player, :game_id => 1, :name => "John", :team => 1
			expect(assigns(:players).length).to be 3
		end

	end

	describe "Load" do

	end

	describe "Play" do

	end
end