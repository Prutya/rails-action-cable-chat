class Message < ApplicationRecord
  AMOUNT_LATEST = 50

  belongs_to :user

  validates  :body, presence: true

  scope :latest, -> { order(:created_at).last(AMOUNT_LATEST) }
end
