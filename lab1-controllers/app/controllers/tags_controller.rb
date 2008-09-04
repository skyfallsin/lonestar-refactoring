class TagsController < ApplicationController
  def tags_for
    @link = Link.find_by_id(params[:link_id])
    @tags = @link.tags
  end
  
  def add_tag
    @link = Link.find_by_id(params[:link_id])
    if request.post?
      @tag = Tag.new
      @tag.text = params[:tag][:text]
      @link.tags << @tag
      flash[:notice] = "Tag saved for link"
      redirect_to "/links"
    else
      render :action => "add_tag"
    end
  end
  
  def delete_tag
    @tag = Tag.find_by_id(params[:tag_id])
    if @tag.destroy
      flash[:notice] = "Tag succesfully deleted."
      redirect_to "/links"
    else
      flash[:error] = "Tag could not be deleted"
      redirect_to "/links"
    end
  end
end