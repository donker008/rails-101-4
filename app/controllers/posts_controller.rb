class PostsController < ApplicationController


def index
    @posts = Post.all
end

def new
  @group = Group.find(params[:group_id])
  @post = Post.new
  @post.group = @group
end

def create

end

def update

end

private

def post_params
  params.require(:post).permit(:content)
end

end
