# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
User.destroy_all
City.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
Gossip.destroy_all
JoinTagToGossip.destroy_all

10.times do
	city = City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
	@user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: rand(15..60), city: city, password: "holaquetal")
	tag = Tag.create(title: Faker::Book.title)
	private_message = PrivateMessage.create(content: Faker::Lorem.paragraph, recipient: @user, sender: @user)
	2.times do
		@gossip = Gossip.create(title: Faker::Lorem.characters(10), content: Faker::Lorem.paragraph, user: @user)
	end
	join_tag_to_gossip = JoinTagToGossip.create(gossip: @gossip, tag: tag)
end
@ville = City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
@anonymous= User.create(first_name: "Arno", last_name: "Nymous", description: "je suis anonyme", email: "arno@nym.ous", age: 23, city: @ville, password: "mescouilles")
