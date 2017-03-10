class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  before_action :check_user_permission, only: [:update, :destory, :edit]

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy

    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "Group deleted!"
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      current_user.join!(@group)
      flash[:notice] = "Group created!"
      redirect_to groups_path
    else
      render :new
    end
  end

  def update

    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:notice] = "Group updated success!"
      redirect_to groups_path
    else
      render :edit
    end

  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page =>params[:page], :per_page => 6)
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
    else
      flash[:warnin] = "You already joined!"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    else
      flash[:warnin] = "You hasn't joined the group!"
    end

    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

  def check_user_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      flash[:warning] = "You dont have permisson!"
      redirect_to root_path
    end
  end
end
