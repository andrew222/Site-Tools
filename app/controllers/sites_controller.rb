class SitesController < ApplicationController
  # GET /sites
  # GET /sites.json
  def index
    @sites = current_user.sites.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = current_user.sites.find(params[:id])
    @external_broken_links = @site.broken_links.where(:link_type => 0).paginate(page: params[:page])
    @internal_broken_links = @site.broken_links.where(:link_type => 1).paginate(page: params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = current_user.sites.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = current_user.sites.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.build(params[:site])

    respond_to do |format|
      if @site.save
        Resque.enqueue(CheckLinksJob, @site.id)
        format.html { redirect_to sites_path, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = current_user.sites.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = current_user.sites.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end
end
