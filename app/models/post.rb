class Post < ApplicationRecord
  belongs_to :user

  validates :body, length: { maximum: 120}, allow_blank: false

end