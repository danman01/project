class CommissionsController < ApplicationController
	load_and_authorize_resource
  def index
    @commissions = Commission.all
  end

  def show
    @commission = Commission.find(params[:id])
  end

  def new
    @commission = Commission.new
  end

  def create
    @commission = Commission.new(params[:commission])
    if @commission.save
      redirect_to @commission, :notice => "Successfully created commission."
    else
      render :action => 'new'
    end
  end

  def edit
    @commission = Commission.find(params[:id])
  end

  def update
    @commission = Commission.find(params[:id])
    if @commission.update_attributes(params[:commission])
      redirect_to @commission, :notice  => "Successfully updated commission."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @commission = Commission.find(params[:id])
    @commission.destroy
    redirect_to commissions_url, :notice => "Successfully destroyed commission."
  end
end
