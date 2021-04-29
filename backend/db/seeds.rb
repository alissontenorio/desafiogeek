require 'benchmark'

#candidates_list = JSON.parse(File.read('restaurant_list.json'))

url = 'https://geekhunter-recruiting.s3.amazonaws.com/code_challenge.json'
candidates_list = JSON.parse(RestClient.get(url, {accept: :json}).body)["candidates"]

def get_lower_year_experience(years_experience)
    years_experience.split('-').first.split('+').first
end

def get_splitted_city_and_state(city_state)
    city_state = city_state.split('-')
    [city_state.first.strip, city_state.last.strip]
end

array_candidates = []
array_candidate_technologies = []

candidates_list.each do |candidate|
    city_state = get_splitted_city_and_state(candidate["city"])
    array_candidates << Candidate.new(id: candidate["id"], city: city_state[0], state: city_state[1],
                      years_experience: get_lower_year_experience(candidate["experience"])).attributes 
    candidate["technologies"].each do |technology|
        tech_temp =  Technology.find_by(name: technology["name"])
        tech = tech_temp.blank? ? Technology.create(name: technology["name"]) : tech_temp 
        array_candidate_technologies << CandidateTechnology.new(candidate_id: candidate["id"], 
                                    technology_id: tech.id, 
                                    is_main_tech: technology["is_main_tech"]).attributes
    end
end

time = Benchmark.measure {
  Candidate.create(array_candidates)
  CandidateTechnology.create(array_candidate_technologies)
}
puts time.real
