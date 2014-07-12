class BrokenLinksController < ApplicationController
  # GET /broken_links
  # GET /broken_links.json
  before_filter :check_site

  def index
    @broken_links = current_user
                      .sites
                        .find(params[:site_id])
                          .broken_links
                            .where(:link_type => params[:link_type])
                              .paginate(:page => params[:page], per_page: 15)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "broken_links" }
    end
  end

  # GET /broken_links/1
  # GET /broken_links/1.json
  def show
    @broken_link = @site.broken_links.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broken_link }
    end
  end

  # GET /broken_links/new
  # GET /broken_links/new.json
  def new
    
  end

  # GET /broken_links/1/edit
  def edit
    @broken_link = @site.broken_links.find(params[:id])
  end

  # POST /broken_links
  # POST /broken_links.json
  def create
    
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
