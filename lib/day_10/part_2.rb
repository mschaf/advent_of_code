module Day10
  module Part2

    def self.run(input)
      asteroid_locations = []
      input.each_line.each_with_index do |line, y|
        line.split('').each_with_index do |spot, x|
          if spot == '#'
            asteroid_locations << [x, y]
          end
        end
      end

      laser_location = [26, 29]
      asteroid_locations.delete(laser_location)

      asteroid_locations_by_angle = {}
      asteroid_locations.each do |location|
        delta_x = location[0] - laser_location[0]
        delta_y = location[1] - laser_location[1]
        angle = (Math.atan2(delta_x, delta_y)/-1 + Math::PI) % (Math::PI * 2)
        distance = Math.sqrt(delta_x**2 + delta_y**2)
        asteroid_locations_by_angle[angle] ||= []
        asteroid_locations_by_angle[angle] << {distance: distance, location: location, angle: angle}
        asteroid_locations_by_angle[angle].sort_by! { |a| a[:distance] }
      end

      asteroid_locations_by_laser_angle = []
      asteroid_locations_by_angle_array = asteroid_locations_by_angle.to_a.sort_by! { |a| a[0] }

      asteroid_locations_by_angle_array

      until asteroid_locations_by_angle_array.empty?
        asteroid_locations_by_angle_array.map! do |angle, asteroids|
          asteroid_locations_by_laser_angle << asteroids.shift
          asteroids.empty? ? nil : [angle, asteroids]
        end
        asteroid_locations_by_angle_array.compact!
      end

      bet_location = asteroid_locations_by_laser_angle[199][:location]
      return bet_location[0] * 100 + bet_location[1]
    end

  end
end

