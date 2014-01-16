require 'spec_helper'

describe "Home Page > " do
	
	subject {page}

	before do
		visit root_path
	end

	describe "Header" do
		it "should have the nav bar" do
			should have_selector('header.navbar')
		end
		it "should have a link to the home page" do
			find_link('Bowling Score Card')[:href].should == '/'
		end
		it "should have a link to the load game page" do
			find_link('Load Game')[:href].should == '/games/load'
		end
		it "should have a link to the new game page" do
			find_link('New Game')[:href].should == '/games/new'
		end
	end

	describe "Body" do
	end
end