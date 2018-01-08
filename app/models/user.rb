class User < ApplicationRecord
  REGEX_USERNAME = /\w+/

  has_many :messages

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false          },
                       format:     { with: /\A#{REGEX_USERNAME}\z/i },
                       length:     { minimum: 3, maximum: 15        }

  validates :password, presence: true,
                       length:   { minimum: 6 }

  has_secure_password
end
