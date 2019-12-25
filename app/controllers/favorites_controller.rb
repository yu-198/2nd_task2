class FavoritesController < ApplicationController
  def create
  	book = Book.find(params[:book_id])
  	favorite = current_user.favorites.new(book_id: book.id )
  	favorite.save
  	redirect_to request.referrer
  end

  def destroy
  	book = Book.find(params[:book_id])
  	favorite = current_user.favorites.find_by(book_id: book.id)
    # このuserに紐づいたfavoritesテーブルのbook_idの物をfindで持ってくるよ
  	favorite.destroy
    #一つ前のURLに戻すことができる
  	redirect_to request.referrer
  end

end

