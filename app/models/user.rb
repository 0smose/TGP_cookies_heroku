class User < ApplicationRecord
	  attr_accessor :remember_token

	has_secure_password
	belongs_to :city
	has_many :gossips
	has_many :comments
	has_many :sent_messages, foreign_key: "sender_id", class_name: 'PrivateMessage'
	has_many :received_messages, foreign_key: "recipient_id", class_name: 'PrivateMessage'
	has_many :likes, dependent: :destroy
	validates :password, presence: true, length: { minimum: 6 }
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }


	  

# Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.	new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
  	return false if remember_digest.nil
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end



