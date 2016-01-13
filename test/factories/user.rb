FactoryGirl.define do

	sequence :email do |n|
		"jon.doe#{n}@email.net"
	end

	factory :user do

		email
		password "abcd1234"

	end
end
