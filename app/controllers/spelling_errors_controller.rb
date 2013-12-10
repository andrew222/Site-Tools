class SpellingErrorsController < ApplicationController
  # GET /spelling_errors
  # GET /spelling_errors.json
  def index
    @spelling_errors = current_user.sites.find(params[:site_id]).spelling_errors.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "spelling_errors" }
    end
  end

  # GET /spelling_errors/1
  # GET /spelling_errors/1.json
  def show
    # @spelling_error = current_user.sites.spelling_errors.find(params[:id])

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @spelling_error }
    # end
  end

  # GET /spelling_errors/new
  # GET /spelling_errors/new.json
  def new
    
  end

  # GET /spelling_errors/1/edit
  def edit
  end

  # POST /spelling_errors
  # POST /spelling_errors.json
  def create
    
  end

  # PUT /spelling_errors/1
  # PUT /spelling_errors/1.json
  def update
    
  end

  # DELETE /spelling_errors/1
  # DELETE /spelling_errors/1.json
  def destroy
    # @spelling_error = current_user.sites.spelling_error.find(params[:id])
    # @spelling_error.destroy

    # respond_to do |format|
    #   format.html { redirect_to spelling_errors_url }
    #   format.json { head :no_content }
    # end
  end
end
