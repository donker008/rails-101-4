class PostsController < ApplicationController


def index
    @posts = Post.all
end

def new
  @group = Group.find(params[:group_id])
  @post = Post.new
end

def create

 @group = Group.find(params[:group_id])
 @post = Post.new(post_params)
 @post.group = @group
 @post.user = current_user
 if @post.save
   flash[:notice] = "Post success!"
   redirect_to group_path(@group)
 else
   render :new
 end

end

def update

end

private

def post_params
  params.require(:post).permit(:content)
end

end