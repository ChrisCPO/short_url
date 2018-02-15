class UrlsController < ApplicationController
  def index
    @urls = Url.all.order(created_at: :desc).decorate
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.create_path
    if @url.save
      redirect_to urls_path
    else
      render :new
    end
  end

  def visit
    @url = Url.find_by(path: params[:path])
    redirect_to @url.full_route, status: 302
  end

  private

  def url_params
    params.require(:url).permit(:route)
  end
end
