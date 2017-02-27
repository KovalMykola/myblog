class CommentsController < ApplicationController
  

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    #redirect_to post_path(@post)

 
   
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comments was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post }
        format.json { render json: @post.comments.build.errors, status: :unprocessable_entity }
      end
    end
   

  end
 
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
