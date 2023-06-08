class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  validates :username, uniqueness: { case_sensitive: false }
  has_one_attached :image

  def messages
    Message.where(from: self).or(Message.where(to: self))
  end

  def recevied_messages_from(recipient)
    Message.where(from: recipient, to: self)
  end

  def direct_messages_with(recipient)
    Message.where(from: recipient, to: self).or(Message.where(from: self, to: recipient))
  end

  def unread_messages_with(user)
    direct_messages_with(user).where(to: self, read: [nil, false]).count
  end

  def color
    hash = Digest::MD5.hexdigest(username)
    decimal = hash[0..5].to_i(16)
    "#" + decimal.to_s(16).rjust(6, '0')
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
