#candidates_list = JSON.parse(File.read('restaurant_list.json'))
url = 'https://geekhunter-recruiting.s3.amazonaws.com/code_challenge.json'
candidates_list = JSON.parse(RestClient.get(url, {accept: :json}).body)["candidates"]

candidates_list.each do |candidate|
    Candidate.create( id: candidate["id"],city: candidate["city"], experience: candidate["experience"] ) 
    candidate["technologies"].each do |technology|
        CandidateTechnology.create( candidate_id: candidate["id"], 
                                name: technology["name"], is_main_tech: technology["is_main_tech"] )
    end
end