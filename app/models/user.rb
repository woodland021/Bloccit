class User < ActiveRecord::Base

  before_save { self.email = email.downcase if email.present? }
  before_save :split_name

  validates :name, length: { minimum: 1, maximum: 100}, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 254 }

  has_secure_password

  def split_name
    if self.name
      name_array = []
      self.name.split.each do |n|
        name_array << n.capitalize
      end
      self.name = name_array.join(" ")
    end
  end
end
