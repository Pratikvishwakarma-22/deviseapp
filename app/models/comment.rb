class Comment < ApplicationRecord
  belongs_to :article

  validates :comment, presence: true, length: { minimum: 10 }
end
