class UrlsController < ApplicationController
  def index
    @urls = urls_list
  end

  def create
    url = Url.new(url_params)
    url.create_path
    url.save

    @urls = urls_list

    render partial: "urls/list"
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy

    redirect_to urls_path
  end

  def visit
    @url = Url.find_by(path: params[:path])
    redirect_to @url.full_route, status: 302
  end

  private

  def urls_list
    Url.all.order(created_at: :desc).decorate
  end

  def url_params
    params.require(:url).permit(:route)
  end
end
