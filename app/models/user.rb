class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  validates :username, uniqueness: { case_sensitive: false }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
