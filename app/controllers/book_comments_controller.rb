class BookCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		# book_commentsコントローラーのdestroyアクションをしたい時親のidと子のidが必要となる（親がbook 子がbook_comments）
		book = Book.find(params[:book_id])#親のidを探す
		book_comment = current_user.book_comments.find(params[:id])#子のidを探す
		book_comment.destroy
		redirect_to book_path(book)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end

