class Post < ApplicationRecord
	has_many :post_comments
	has_many :likes
	belongs_to :user

  validates :store, presence: true
  validates :station, presence: true

	attachment :post_image_name

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Post.where(['station LIKE ?', "%#{search}%"])
    else
      Post.all #全て表示。
    end
  end
end
