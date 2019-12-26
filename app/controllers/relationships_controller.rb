class RelationshipsController < ApplicationController
	def create
  	# current_user.active_relationships.build(引数)で
  	# [following_id: :current_user_id]を代入しながらインスタンスを生成できる
  	follow = current_user.active_relationships.build(follower_id: params[:user_id])
  	follow.save
  	redirect_to request.referrer
  end

  def destroy
  	# current_user.active_relationships.find_by(引数)で
  	# このuserに紐づいたrelationテーブルの[following_id: :current_user_id]の物をfindで持ってくるよ
  	follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
  	follow.destroy
  	redirect_to request.referrer
  end
end
