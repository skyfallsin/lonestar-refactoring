class LinksController < ApplicationController
  before_filter :find_link, :except => [:new, :create]
  
  def index
    @links = Link.created_since_three_weeks_ago
  end
  
  def new
    @link = Link.new(params[:link])
  end
  
  def edit
    @link = Link.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not find the link you specified"
    redirect_to :back
  end
  
  def create
    @link = Link.find(params[:id])
    @link.save!
    flash[:notice] = "The link you submitted has been saved successfully!"
    api_response(@link, :ok) { redirect_to links_path }
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not find the link you specified"
    api_response(nothing, :not_found) { new; render :action => "new" }
  rescue ActiveRecord::RecordNotSaved
    flash[:error] = "Could not save the link you submitted"
    api_response(nothing, :bad_request) { render :action => "new" }
  end
  
  def update
    @link.update_attributes!(params[:link])
    flash[:notice] = "The link has been updated successfully"
    api_response(@link, :ok) { redirect_to links_path } 
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not find the link you specified"
    api_response(nothing, :not_found) { render :action => "edit" }
  rescue ActiveRecord::RecordNotSaved
    flash[:error] = "Could not update the link"
    api_response(nothing, :bad_request) { render :action => "edit" }
  end
  
  def destroy
    @link.destroy
    flash[:notice] = "Link deleted"
    api_response(nothing, :ok) { redirect_to links_path }
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not find the link you specified"
    api_response(nothing, :not_found) { redirect_to :back }
  end
  
  protected
  # this will eventually go in application.rb
  def api_response(object, status_code, &block)
    formats = [:xml, :json]
    xml, json = gather_api_responses(object, status_code, *formats)
    respond_to do |format|
      format.html { block.call         }
      format.xml  { xml_response.call  }
      format.json { json_response.call }
    end
  end
  
  def gather_api_responses(object, status_code, *formats)
    if object
      formats.collect do |format|
        Proc.new { render(format => object, :status => status_code) }
      end
    else
      [Proc.new{ render(:nothing => true, :status => status_code) }]*formats.size
    end
  end
  
  def nothing
    false end
end