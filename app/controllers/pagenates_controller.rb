class PagenatesController < ApplicationController
  # GET /pagenates
  # GET /pagenates.json
  def index
    @pagenates = Pagenate.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pagenates }
    end
  end

  # GET /pagenates/1
  # GET /pagenates/1.json
  def show
    @pagenate = Pagenate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pagenate }
    end
  end

  # GET /pagenates/new
  # GET /pagenates/new.json
  def new
    @pagenate = Pagenate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pagenate }
    end
  end

  # GET /pagenates/1/edit
  def edit
    @pagenate = Pagenate.find(params[:id])
  end

  # POST /pagenates
  # POST /pagenates.json
  def create
    @pagenate = Pagenate.new(params[:pagenate])

    respond_to do |format|
      if @pagenate.save
        format.html { redirect_to @pagenate, notice: 'Pagenate was successfully created.' }
        format.json { render json: @pagenate, status: :created, location: @pagenate }
      else
        format.html { render action: "new" }
        format.json { render json: @pagenate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pagenates/1
  # PUT /pagenates/1.json
  def update
    @pagenate = Pagenate.find(params[:id])

    respond_to do |format|
      if @pagenate.update_attributes(params[:pagenate])
        format.html { redirect_to @pagenate, notice: 'Pagenate was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pagenate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagenates/1
  # DELETE /pagenates/1.json
  def destroy
    @pagenate = Pagenate.find(params[:id])
    @pagenate.destroy

    respond_to do |format|
      format.html { redirect_to pagenates_url }
      format.json { head :ok }
    end
  end
end
