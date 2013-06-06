class BrokenLinksController < ApplicationController
  # GET /broken_links
  # GET /broken_links.json
  def index
    @broken_links = BrokenLink.all
    p "$$$broken_links"
    p @broken_links
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @broken_links }
    end
  end

  # GET /broken_links/1
  # GET /broken_links/1.json
  def show
    @broken_link = BrokenLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broken_link }
    end
  end

  # GET /broken_links/new
  # GET /broken_links/new.json
  def new
    @broken_link = BrokenLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @broken_link }
    end
  end

  # GET /broken_links/1/edit
  def edit
    @broken_link = BrokenLink.find(params[:id])
  end

  # POST /broken_links
  # POST /broken_links.json
  def create
    @broken_link = BrokenLink.new(params[:broken_link])

    respond_to do |format|
      if @broken_link.save
        format.html { redirect_to @broken_link, notice: 'Broken link was successfully created.' }
        format.json { render json: @broken_link, status: :created, location: @broken_link }
      else
        format.html { render action: "new" }
        format.json { render json: @broken_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /broken_links/1
  # PUT /broken_links/1.json
  def update
    @broken_link = BrokenLink.find(params[:id])

    respond_to do |format|
      if @broken_link.update_attributes(params[:broken_link])
        format.html { redirect_to @broken_link, notice: 'Broken link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @broken_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /broken_links/1
  # DELETE /broken_links/1.json
  def destroy
    @broken_link = BrokenLink.find(params[:id])
    @broken_link.destroy

    respond_to do |format|
      format.html { redirect_to broken_links_url }
      format.json { head :no_content }
    end
  end
end
