class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
          
  # posts
  has_many :provider_posts, class_name: 'Post', dependent: :destroy
            #, foreign_key: 'provider',
  has_many :recipient_posts, class_name: 'Post'
            #, foreign_key: 'recipient'

  # comments
  has_many :comments
end
