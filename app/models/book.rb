class Book < ApplicationRecord
  belongs_to :category
  validates :title, :author, :isbn, presence: true
end