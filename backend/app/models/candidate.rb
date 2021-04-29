class Candidate < ApplicationRecord
    validates :city, presence: true
    validates :state, presence: true
    validates :years_experience, presence: true

    has_many :candidate_technologies, dependent: :destroy

    def self.get_5_best_matches(years_experience_min, years_experience_max, city_state, 
                              technologies = ",")
      years_experience_min = years_experience_min.present? ? years_experience_min.to_i : 0
      years_experience_max = years_experience_max.present? ? years_experience_max.to_i : 999
      city_state = city_state.present? ? city_state.strip : 'Remote'
      technologies = "," if technologies.nil?
      technologies = technologies.split(',').map{|k| k.strip}
      ids_technologies = []
      technologies.map{|k| ids_technologies << Technology.find_by(name: k).id}
      ids_technologies = "'#{ids_technologies.join("','")}'"
      
      city_state = "'#{city_state}'"

      matches = connection.execute """
        select cs.id, cs.city_state as city, cs.years_experience, (cs.sumYears + cs.sumCities + cs.sumTechs) as score_points
        from (
          select cd.id as id, cd.city_state as city_state, cd.years_experience as years_experience, 
          CASE WHEN cd.years_experience >= #{years_experience_min} and cd.years_experience <=  #{years_experience_max} 
                    THEN 1 ELSE 0 END AS sumYears,
          case WHEN cd.city_state = #{city_state} THEN 1 ELSE 0 END AS sumCities,
          ct.sumTech as sumTechs
          FROM (
            SELECT id, 
                  years_experience, 
                  CONCAT(city, ' - '  ,state) as city_state
            FROM candidates c 
          ) AS cd 
          INNER JOIN  (
            SELECT candidate_id, 
            count(CASE WHEN is_main_tech = true and technology_id IN (#{ids_technologies}) THEN 1 END) as sumTech
            from candidate_technologies ct 
            GROUP BY candidate_id) ct
          ON cd.id=ct.candidate_id 
        ) as cs
        ORDER BY score_points desc, years_experience desc
        LIMIT 5;    
        """
      matches
    end  
end
