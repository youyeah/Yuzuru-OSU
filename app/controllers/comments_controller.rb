class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        redirect_back(fallback_locatuin: root_path) unless user_signed_in?
        if @comment.save!
            redirect_back(fallback_location: root_path)
        else
            redirect_to("/") and return
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end
end
