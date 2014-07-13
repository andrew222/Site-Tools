class BrokenLinksController < ApplicationController
  before_filter :check_site

  # GET /broken_links/1
  # GET /broken_links/1.json
  def show
    @broken_link = @site.broken_links.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broken_link }
    end
  end

  # GET /broken_links/1/edit
  def edit
    @broken_link = @site.broken_links.find(params[:id])
  end

  # PUT /broken_links/1
  # PUT /broken_links/1.json
  def update
    
  end

  # DELETE /broken_links/1
  # DELETE /broken_links/1.json
  def destroy
    @broken_link = @site.broken_links.find(params[:id])
    @broken_link.destroy

    respond_to do |format|
    format.html { redirect_to @site }
      format.json { head :no_content }
    end
  end

  def check_site
    @site = current_user.sites.find(params[:site_id])
  end
end
