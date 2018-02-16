class UrlDecorator < Draper::Decorator
  delegate_all

  ROUTE_LENGTH = 37
  ROUTE_TAG = "..."
  ROUTE_LENGTH_LIMIT = ROUTE_LENGTH + ROUTE_TAG.length

  def display_route
    if route.length > ROUTE_LENGTH_LIMIT
      route[0...ROUTE_LENGTH] + ROUTE_TAG
    else
      route
    end
  end

  def created_at
    object.created_at.strftime("%d %b, %Y")
  end
end
