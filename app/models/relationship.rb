class Relationship < ApplicationRecord
	# この記述でfollowモデル、followerモデルを擬似的に作り出すことができる
	# :classL_nameは関連するモデルのクラス名を指定
	belongs_to :following, class_name: "User"
	belongs_to :follower, class_name: "User"
end
