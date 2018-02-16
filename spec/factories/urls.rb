FactoryGirl.define do
  factory :url do
    route "http://www.example.com/"
  end

  trait(:with_path) do
    before(:create) do |url|
      url.create_path
      url.save
    end
  end
end
