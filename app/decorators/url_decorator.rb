class UrlDecorator < Draper::Decorator
  delegate_all

  ROUTE_LENGTH = 37
  ROUTE_TAG = "..."

  def display_route
    route[0...ROUTE_LENGTH] + ROUTE_TAG
  end

  def created_at
    object.created_at.strftime("%d %b, %Y")
  end
end
