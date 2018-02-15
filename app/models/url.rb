class Url < ApplicationRecord

  DEFAULT_PATH_LENGTH = 5

  validates :route, presence: :true, uniqueness: true
  validates :path, presence: :true

  def route=(new_route)
    super(strip_http(new_route))
  end

  def create_path(length: DEFAULT_PATH_LENGTH)
    self.path = unique_path(length)
  end

  def full_route
    "http://" + route
  end

  def full_path
    "/u/" + path
  end

  private

  def unique_path(length)
    lazy_random_enumerator(length).detect do |random|
      random_is_unique?(random)
    end
  end

  def random_is_unique?(random)
    !Url.find_by(path: random)
  end

  def strip_http(string)
    string = string || ""
    string.gsub("http://", "")
  end

  def lazy_random_enumerator(length)
    Enumerator.new do |yielder|
      loop do
        yielder.yield(new_random_path(length))
      end
    end
  end

  def new_random_path(length)
    SecureRandom.hex(length)
  end
end
