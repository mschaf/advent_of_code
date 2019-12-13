module Day12
  module Part2

    def self.run(input)
      moon_positions = input.scan(/<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/m).map{ |row| row.map(&:to_i) }.transpose
      moon_velocities = [[0] * 4] * 3
      start_positions = moon_positions.map(&:clone)
      start_velocities = moon_velocities.map(&:clone)
      n_cycles = [0] * 3

      (0...3).each do |axis|

        while true
          (0...4).each do |moon|
            (0...4).each do |other_moon|
              moon_velocities[axis][moon] += moon_positions[axis][other_moon] <=> moon_positions[axis][moon]
            end
          end

          (0...4).each do |moon|
            moon_positions[axis][moon] += moon_velocities[axis][moon]
          end

          n_cycles[axis] += 1

          if moon_positions[axis] == start_positions[axis] && moon_velocities[axis] == start_velocities[axis]
            break
          end
        end

      end

      return n_cycles.reduce(:lcm)
    end

  end
end

