class Album < ApplicationRecord
  validates :title, presence: true, length: {minimum:5}, uniqueness: true
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
end
