class LinksController < ApplicationController
  
  # lists the links in the database
  def list
    @links = Link.find(:all, :conditions => "created_at > '#{(Time.now - 1814400).to_s(:db)}'", 
                                 :order => "created_at DESC")
    render :action => "list"
  end
  # end links
  
  # adds the link to the database 
  def add_link
    if request.post?
      @link = Link.new
      @link.url = params[:link][:url]
      if params[:link][:name]
        @link.name = params[:link][:name]
      else
        @link.name = "Unknown Link"
      end
      
      # generates the unique identifier for each url
      # make http://www.yahoo.com into yahoo.com
      @link.curl = @link.url.gsub("http://", "").gsub("https://", "").gsub("www.", "")
      
      if @link.save
          flash[:notice] = "The link you submitted has been saved successfully!"
          redirect_to "/links"
      else
        flash[:error] = "Could not save the link you submitted"
        redirect_to "/links/add_link"
      
      end
      
    else
      render :action => "add_link"
    end
  end
  # end add_link
  
  # edit_link page
  def edit_link
    @link = Link.find_by_id(params[:link_id])
  end
  # end edit_link
  
# updates the link in the database
def update_link
  if request.post?
    @link = Link.find_by_id(params[:link_id])
    
    @link.url = params[:link][:url]
    @link.name = params[:link][:name]
    
    
    if @link.save
      flash[:notice] = "The link has been updated successfully"
      redirect_to "/links"
    else
      flash[:error] = "Could not update the link"
      redirect_to "/links/update_link"
    end
  else
    render :action => "update_link"
  end
end
# end update_link
  
  # def search_links
  #   if request.post?
  #     
  #   else
  #     render :action => "search_links"
  #   end
  # end
  
  # deletes the link in the database
  def delete_link
    @link = Link.find_by_id(params[:id])
    if request.post?
      if @link.destroy
        flash[:notice] = "Link deleted"
        redirect_to "/links"
      else
        flash[:error] = "Link could not be deleted"
        redirect_to "/links"
      end
      
    else
      flash[:notice] = "You cannot delete links using this request format"
      redirect_to "/links"
    end
  end
  # end delete_link
end