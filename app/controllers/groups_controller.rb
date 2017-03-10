class GroupsController < ApplicationController

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
    @group.save
    flash[:notice] = "Group created!"
    redirect_to groups_path
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:notice] = "Group updated success!"
    else
      flash[:warning] = "Group updated failed!"
    end
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end
end