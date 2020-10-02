class User < ApplicationRecord

   attr_accessor :remember_token
   before_save :downcase_email
   # before_create :create_activation_digest


   has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
   has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
   has_many :following, through: :active_relationships, source: :followed
   has_many :followers, through: :passive_relationships, source: :follower
   has_many :posts, dependent: :destroy
   validates :user_name, presence: true, length: { maximum: 50}
   VALID_EMAIL_REGEX =/\A(\S+)@(.+)\.(\S+)\z/
   validates :email,  presence: true, length: { maximum: 255} ,
                  format: { with: VALID_EMAIL_REGEX},
                  uniqueness: true  
   has_secure_password
   validates :password, presence: true ,length: { minimum: 6}, allow_nil: true
   
   
   #Return's a random token

  
   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
   
   def User.new_token
      SecureRandom.urlsafe_base64
   end

   # Remembers a user in the database for use in presistent session
   def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
   end

   # Returns true if the given token matches the digest.
   def authenticated? (remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
   end
   
   def forget
      update_attribute(:remember_digest, nil)
   end

   #Defines a protoFeed
   def feed
      following_ids = "SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id"
      Post.where("user_id IN (#{following_ids})
                   OR user_id = :user_id ", user_id: id)
   end

   # Follows a user.
   def follow(other_user)
      following << other_user
   end

   # Unfollows a user.
   def unfollow(other_user)
      following.delete(other_user)
   end

   def following?(other_user)
      following.include?(other_user)
   end

   private

      def downcase_email
         self.email = email.downcase 
      end
      
      
     


end


 # def create_activation_digest
      #    self.activation_token = User.new_token
      #    self.activation_digest = User.digest(activation_token)
      # end