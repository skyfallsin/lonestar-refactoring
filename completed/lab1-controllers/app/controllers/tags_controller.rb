class TagsController < ApplicationController
  def tags_for
    @link = Link.find(params[:link_id])
    @tags = @link.tags
  end
  
  def create
    @link = Link.find(params[:link_id])
    @tag = Tag.new(params[:tag])
    @link.tags << @tag
    flash[:notice] = "Tag saved for link"
    redirect_to links_path
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      flash[:notice] = "Tag succesfully deleted."
    else
      flash[:error] = "Tag could not be deleted"
    end
    redirect_to links_path
  end
end