class LinksController < ApplicationController
  before_filter :find_link, :except => [:new, :create]
  before_filter :create_link, :only => [:new, :create]
  
  def index
    @links = Link.created_since_three_weeks_ago
  end
  
  def new
  end
  
  def edit
  end
  
  def create
    if @link.save
      flash[:notice] = "The link you submitted has been saved successfully!"
      redirect_to links_path
    else
      flash[:error] = "Could not save the link you submitted"
      render :action => "new"
    end
  end
  
  def update
    if @link.update_attributes(params[:link])
      flash[:notice] = "The link has been updated successfully"
      redirect_to links_path
    else
      flash[:error] = "Could not update the link"
      render :action => "edit"
    end
  end
  
  def destroy
    if @link.destroy
      flash[:notice] = "Link deleted"
    else
      flash[:error] = "Link could not be deleted"
    end
    redirect_to links_path
  end
  
  protected
  def create_link
    @link = Link.new(params[:link])
  end
  
  def find_link
    @link = Link.find(params[:id])
  end
end