module UrlHelper
  def urls_defined_path(url)
    request.base_url + url.full_path
  end
end
