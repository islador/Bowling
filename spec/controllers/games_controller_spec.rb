require 'spec_helper'

describe GamesController do
	

	describe "New" do
		it "should create a new game called games" do
			#@time_now = Time.new(2014, 1, 15, 2, 2, 2, "-08:00")
			#Time.stub(:now).and_return(@time_now)

			#game = FactoryGirl.create(:game)

			get :new
			expect(assigns(:game))
			#be_a_new(Game)#.to be true #have_same_attributes_as(game)
		end

		it "should render the new page" do
			get :new
			expect(response).to render_template("new")
		end
	end

	describe "Add Player" do
		let!(:game) {FactoryGirl.create(:game)}

		it "should create players based on the parameters it is sent" do
			xhr :post, :add_player, :game_id => 1, :name => "John", :team => 1

			expect(assigns(:player).name).to match game.players[-1].name
			expect(assigns(:player).team).to be game.players[-1].team
			expect(assigns(:player)).to_not be_nil
		end
	end

	describe "Load" do

	end

	describe "Play" do

	end
end