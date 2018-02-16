class WebAddressValidator < ActiveModel::Validator
  def validate(record)
    begin
      response = get(record.full_route)
      if response_is_400_or_500?(response.code)
        add_error(record)
      end
    rescue => error
      puts error
      add_error(record)
    end
  end

  private

  def add_error(record)
    record.errors[:route] << I18n.t("activerecord.errors.url.route.invalid_url")
  end

  def response_is_400_or_500?(code)
    code.first == "4" || code.first == "5"
  end

  def get(path)
    uri = URI(path)
    Net::HTTP.get_response(uri)
  end
end
