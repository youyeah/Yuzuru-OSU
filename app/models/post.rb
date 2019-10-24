class Post < ApplicationRecord

  # user
  belongs_to :provider,  class_name: 'User'                #, foreign_key: 'provider'
  belongs_to :recipient, class_name: 'User', optional: true#, foreign_key: 'recipient'
  # belongs_to :provider_id,  class_name: 'User'                #, foreign_key: 'provider'
  # belongs_to :recipient_id, class_name: 'User', optional: true#, foreign_key: 'recipient'

  # validates
  validates :provider, presence: true
  validates :title,    presence: true, length: { minimum: 1 , maximum: 30}
  validates :lecture,  presence: true, length: { minimum: 1 , maximum: 20}
  validates :status,   presence: true
  validates :content,  presence: true, length: { minimum: 1 , maximum: 100}
  

  # comments
  has_many :comments

  enum status: {
    掲載中: 0, 受け渡し中: 1, 受け渡し完了: 2
  }
end
