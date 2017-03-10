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

def edit

  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  if current_user != @post.user
    redirect_to root
  end
end

def update
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  if current_user == @post.user &&  @post.update(post_params)
    flash[:notice] = "update success"
  end
  redirect_to account_posts_path
end

def destroy
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  if current_user == @post.user and @post.destroy
    flash[:notice] = "Delete post success!"
  end
  redirect_to account_posts_path
end

private

def post_params
  params.require(:post).permit(:content)
end

end
