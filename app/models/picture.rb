class Picture < ApplicationRecord
  #バリデーション
  validates :title, presence: true,length: { maximum: 40 }
  validates :content, presence: true,length: { maximum: 140 }

  #この「picture」情報は、「user」情報に従属する
  belongs_to :user

  #「image」列で「ImageUploader」というアップローダーをmountする
  mount_uploader :image,ImageUploader

end
