class Candidate < ApplicationRecord
    validates :city, presence: true
    validates :district, presence: true
    validates :years_experience, presence: true

    has_many :candidate_technologies, dependent: :destroy

    def self.get_5_best_matches_by_experience_city_and_technology(years_experience, city, technology)
        # todo vai receber uma lista de tecnologias ao invés de apenas uma
        c = Candidate.where("years_experience >= ? AND LOWER(city) = ?", years_experience, city.downcase)
                    .joins(:candidate_technologies).where("name = ? AND is_main_tech = ?", technology, true)    
        c.limit(5)     
    end

    def self.get_5_best_matches(years_experience_min = 0, years_experience_max = 999, city_district = 'Remote', 
                              technologies = ",")
      years_experience_min = years_experience_min.to_i
      years_experience_max = years_experience_max.to_i
      technologies = "," if technologies.nil?
      technologies = technologies.split(',')
      technologies = "'#{technologies.join("','")}'"
      city_district = "'#{city_district}'"

      matches = connection.execute """
        select cs.id, cs.city_district as city, cs.years_experience, (cs.sumYears + cs.sumCities + cs.sumTechs) as score_points
        from (
          select cd.id as id, cd.city_district as city_district, cd.years_experience as years_experience, 
          CASE WHEN cd.years_experience >= #{years_experience_min} and cd.years_experience <=  #{years_experience_max} 
                    THEN 1 ELSE 0 END AS sumYears,
          case WHEN cd.city_district = #{city_district} THEN 1 ELSE 0 END AS sumCities,
          ct.sumTech as sumTechs
          FROM (
            SELECT id, 
                  years_experience, 
                  CONCAT(city, ' - '  ,district) as city_district
            FROM candidates c 
          ) AS cd 
          INNER JOIN  (
            SELECT candidate_id, 
            count(CASE WHEN is_main_tech = true and name IN (#{technologies}) THEN 1 END) as sumTech
            from candidate_technologies ct 
            GROUP BY candidate_id) ct
          ON cd.id=ct.candidate_id 
        ) as cs
        ORDER BY score_points desc
        LIMIT 5;    
        """
      matches
    end  
end
