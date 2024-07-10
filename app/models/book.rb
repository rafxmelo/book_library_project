class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  validates :title, :isbn, presence: true
end
