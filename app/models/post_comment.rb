class PostComment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :title, {presence: true, length:{maximum: 20}}
	validates :rating, presence: true
	validates :comment, {presence: true, length:{maximum: 200}}

	attachment :post_image_name
end
