class User < ApplicationRecord
  paginates_per Settings.admin.user.per_page

  belongs_to :office, optional: true

  has_many :pull_requests, primary_key: :github_account, foreign_key: :github_account

  attr_accessor :remember_token

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  enum role: [:normal, :trainer, :admin, :supporter]

  ATTR_PARAMS = [:name, :email, :office_id, :github_account, :chatwork_id,
    :chatwork_room_id, :role].freeze

  delegate :name, to: :office, prefix: true, allow_nil: true

  scope :search, lambda{|keyword|
    where "name LIKE ? OR email LIKE ? OR github_account LIKE ?",
      "%#{keyword}%", "%#{keyword}%", "%#{keyword}%" if keyword.present?
  }

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def from_omniauth auth
      # user = find_or_initialize_by(email: auth.info.email)
      user = User.find_by email: auth.info.email

      return user if user.present?
      user.name = auth.info.name
      user.provider = auth.provider
      user.password = User.generate_unique_secure_token if user.new_record?
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.save
      user
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def merged_pulls_size
    pull_requests.merged.in_current_month.size
  end
end
