module Day10
  module Part1

    def self.run(input)
      asteroid_locations = []
      input.each_line.each_with_index do |line, y|
        line.split('').each_with_index do |spot, x|
          if spot == '#'
            asteroid_locations << [x, y]
          end
        end
      end

      best_location = nil
      most_visible = 0

      asteroid_locations.each do |possible_location|
        other_asteroids = asteroid_locations.clone
        other_asteroids.delete(possible_location)

        center_x, center_y = possible_location
        other_asteroids.map! do |other_asteroid|
          delta_x, delta_y = other_asteroid
          delta_x -= center_x
          delta_y -= center_y
          gcd = delta_x.gcd(delta_y)
          delta_x /= gcd
          delta_y /= gcd
          [delta_x, delta_y]
        end

        other_asteroids.uniq!
        visible_count = other_asteroids.count
        if visible_count > most_visible
          most_visible = visible_count
          best_location = possible_location
        end
      end

      return most_visible
    end

  end
end

