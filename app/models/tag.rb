class Tag < ApplicationRecord
	has_many :join_tag_to_gossips
	has_many :gossips, through: :join_tag_to_gossips
end
