class Util
  def self.get_splitted_city_and_district(city_district)
    city_district = city_district.split('-')
    [city_district.first.strip, city_district.last.strip]
  end
end