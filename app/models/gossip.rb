class Gossip < ApplicationRecord

	validates :title, length: { minimum: 3, maximum: 14},
	presence: true
	validates :content, 
	presence: true

	belongs_to :user
	has_many :comments
	has_many :join_tag_to_gossips
	has_many :tags, through: :join_tag_to_gossips
	has_many :likes, dependent: :destroy

end
