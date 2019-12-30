class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # :foreign_key - 参照先のテーブルの外部キーのカラム名を指定できる
  # following_id, follower_id、つまり親のprimary_keyを指定してあげれば、「フォローする側のUserからみた」と言う情報も取得
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # has many throughで(中間テーブルを介して)followinsの時はfollowerを、followersの時はfollowingを集める記述をしています。
  # throughはhas_many :through関連付けは、他方のモデルと「多対多」のつながりを設定する場合によく使われます。
  # この関連付けは、2つのモデルの間に「第3のモデル」(joinモデル)が介在する点が特徴です。
  # もちろんsourceでモデルの参照元を指定しています。
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships,class_name: "Relationship",foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)
    # の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def User.search(search, user_or_book, how_search)
    if user_or_book == "1"
        if how_search == "1"
          User.where(['name LIKE ?',"%#{search}%"])
        elsif how_search == "2"
          User.where(['name LIKE ?',"%#{search}%"])
        elsif how_search == "3"
          User.where(['name LIKE ?',"%#{search}%"])
        elsif how_search == "4"
          User.where(['name LIKE ?',"%#{search}%"])
        else
          User.all
        end
      end
    end

  attachment :profile_image, destroy: false
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end
