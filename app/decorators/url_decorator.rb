class UrlDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%d %b, %Y")
  end
end
