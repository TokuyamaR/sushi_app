class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, {presence: true,length:{in: 2..20}}
  validates :introduction, length:{maximum:50}

  has_many :posts
  has_many :post_comments
  has_many :likes

  attachment :user_image_name
end
