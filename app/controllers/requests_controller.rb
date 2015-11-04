class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    request_params = params.require(:request).
                        permit([:name, :email, :department, :message])
    @request = Request.new request_params
    if @request.save
      redirect_to request_path(@request)
    else
      render :new
    end
  end

  def show
    @request = Request.find params[:id]
  end

  def edit
    @request = Request.find params[:id]
  end

  def update
    @request = Request.find params[:id]
    request_params = params.require(:request).
                      permit(:name, :email, :department, :message, :done)
    if @request.update request_params
      if request_params.has_key?(:done)
        redirect_to requests_path
      else
        redirect_to request_path(@request)
      end
    else
      render :edit
    end
  end

  def destroy
    @request = Request.find params[:id]
    @request.destroy
    redirect_to requests_path
  end

  def index
    @query    = params[:query]
    @requests = Request.order("done ASC").page(params[:page]).per(5).search(params[:query])
  end

end
