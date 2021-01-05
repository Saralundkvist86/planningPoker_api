class Api::CommentsController < ApplicationController
    def create
        poll = Poll.find(params[:poll_id])
        comment = poll.comments.create(params[:comment].permit(:user_name, :comment))
        if comment.persisted?
            render json: { message: 'successfully saved'}
          else
            error_message(comments.errors)
          end
    end
end