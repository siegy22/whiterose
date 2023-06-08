class Message < ApplicationRecord
  encrypts :body

  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'

  scope :ordered, -> { order(created_at: :desc)}

  def encrypt_if_necessary!
    return if body.include?("-----BEGIN PGP MESSAGE-----") || to.pub_key_uid.blank?

    crypto = GPGME::Crypto.new
    enc_message = crypto.encrypt(body, recipients: to.pub_key_uid, always_trust: true)
    self.body = format_pgp_message(enc_message)
  end

  def unread?
    !read
  end

  private
  def format_pgp_message(msg)
    "-----BEGIN PGP MESSAGE-----\n#{Base64.encode64(msg.to_s)}-----END PGP MESSAGE-----"
  end
end
