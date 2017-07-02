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

  enum role: [:normal, :trainer, :admin]

  ATTR_PARAMS = [:name, :email, :office_id, :role, :password, :password_confirmation].freeze

  delegate :name, :office_id, to: :office, prefix: true, allow_nil: true

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
      user = find_or_initialize_by(email: auth.info.email)
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
    pull_requests.merged.size
  end
end
