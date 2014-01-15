FactoryGirl.define do
	
	factory :game do
		date Date.today
		start_time Time.new(2014, 1, 15, 2, 2, 2, "-08:00")

		factory :finished_game do
			end_time Time.new(2014, 1, 15, 3, 2, 2, "-08:00")
		end
	end

	factory :player do
		ignore do
			sequence(:set_name) {|n| "Player #{n}"}
			sequence(:set_team) {|t| n}
		end
		name {set_name}
		team {set_team}

		game
	end

	factory :scorecard do
		throw1 0
		throw2 0
		throw3 0
		throw4 0
		throw5 0
		throw6 0
		throw7 0
		throw8 0
		throw9 0
		throw10 0
		throw11 0
		throw12 0
		throw13 0
		throw14 0
		throw15 0
		throw16 0
		throw17 0
		throw18 0
		throw19 0
		throw20 0
		throw21 0
		total 0

		player

		factory :perfect_scorecard do
			throw1 10
			throw2 0
			throw3 10
			throw4 0
			throw5 10
			throw6 0
			throw7 10
			throw8 0
			throw9 10
			throw10 0
			throw11 10
			throw12 0
			throw13 10
			throw14 0
			throw15 10
			throw16 0
			throw17 10
			throw18 0
			throw19 10
			throw20 10
			throw21 10
			total 300
		end
	end
end