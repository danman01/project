class LookingForsController < ApplicationController
  # GET /looking_fors
  # GET /looking_fors.xml
  def index
    @looking_fors = LookingFor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @looking_fors }
    end
  end

  # GET /looking_fors/1
  # GET /looking_fors/1.xml
  def show
    @looking_for = LookingFor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @looking_for }
    end
  end

  # GET /looking_fors/new
  # GET /looking_fors/new.xml
  def new
    @looking_for = LookingFor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @looking_for }
    end
  end

  # GET /looking_fors/1/edit
  def edit
    @looking_for = LookingFor.find(params[:id])
  end

  # POST /looking_fors
  # POST /looking_fors.xml
  def create
    @looking_for = LookingFor.new(params[:looking_for])

    respond_to do |format|
      if @looking_for.save
        format.html { redirect_to(@looking_for, :notice => 'Looking for was successfully created.') }
        format.xml  { render :xml => @looking_for, :status => :created, :location => @looking_for }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @looking_for.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /looking_fors/1
  # PUT /looking_fors/1.xml
  def update
    @looking_for = LookingFor.find(params[:id])

    respond_to do |format|
      if @looking_for.update_attributes(params[:looking_for])
        format.html { redirect_to(@looking_for, :notice => 'Looking for was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @looking_for.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /looking_fors/1
  # DELETE /looking_fors/1.xml
  def destroy
    @looking_for = LookingFor.find(params[:id])
    @looking_for.destroy

    respond_to do |format|
      format.html { redirect_to(looking_fors_url) }
      format.xml  { head :ok }
    end
  end
end
