class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  validates :username, uniqueness: { case_sensitive: false }

  def messages
    Message.where(from: self).or(Message.where(to: self))
  end

  def recevied_messages_from(recipient)
    Message.where(from: recipient, to: self)
  end

  def direct_messages_with(recipient)
    Message.where(from: recipient, to: self).or(Message.where(from: self, to: recipient))
  end

  def pgp_set?
    pub_key_uid
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
