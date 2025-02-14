class User < ApplicationRecord
  has_secure_password
  belongs_to :organization
  has_many :surveys
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create # Only validate password on create
  validates :organization, presence: true

  # validate :email_domain_is_allowed

  private

  # def email_domain_is_allowed
  #   unless email.end_with?('@elitmus.com')
  #     errors.add(:email, 'must belong to the specified organization (elitmus.com)')
  #   end
  # end

  def sso_enabled?
    Rails.configuration.sso_enabled
  end
end
