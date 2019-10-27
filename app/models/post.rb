class Post < ApplicationRecord

  def self.search(title, lecture, status)
    if title
      @posts = where('(title LIKE ? )', "%#{title}%")
      @posts.where('(lecture LIKE ? )', "%#{lecture}%") if lecture
    elsif lecture
      @posts.where('(lecture LIKE ? )', "%#{lecture}%")
    else
      @posts = self.all
    end
    # @posts.where(status: status)
  end

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

  #image
  mount_uploader :image, ImageUploader
  

  # comments
  has_many :comments

  enum status: {
    募集中: 0, 受け渡し中: 1, 受け渡し完了: 2
  }
  enum condition:{
    新品: 1, ほぼ新品: 2, きれい: 3, きたない: 4, 出品不可: 5
  }
end
