require 'benchmark'

#candidates_list = JSON.parse(File.read('restaurant_list.json'))

url = 'https://geekhunter-recruiting.s3.amazonaws.com/code_challenge.json'
candidates_list = JSON.parse(RestClient.get(url, {accept: :json}).body)["candidates"]

def get_lower_year_experience(years_experience)
    years_experience.split('-').first.split('+').first
end

def get_splitted_city_and_district(city_district)
    city_district = city_district.split('-')
    [city_district.first.strip, city_district.last.strip]
end

array_candidates = []
array_technologies = []
candidates_list.each do |candidate|
    city_district = get_splitted_city_and_district(candidate["city"])
    array_candidates << Candidate.new(id: candidate["id"], city: city_district[0], district: city_district[1],
                      years_experience: get_lower_year_experience(candidate["experience"])).attributes 
    candidate["technologies"].each do |technology|
        array_technologies << CandidateTechnology.new(candidate_id: candidate["id"], name: technology["name"], 
                                    is_main_tech: technology["is_main_tech"]).attributes
    end
end

time = Benchmark.measure {
  Candidate.create(array_candidates)
  CandidateTechnology.create(array_technologies)
}
puts time.real
