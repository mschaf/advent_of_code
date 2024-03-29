module Day3
  module Part1

    def self.run(input)
      paths = input.each_line
      map = {}

      paths.each_with_index do |path, path_index|
        position_x = 0
        position_y = 0
        path.split(',').each do |segment|
          distance = segment[1..-1].to_i

          (0...distance).each do |d|
            case segment[0]
            when 'R'
              position_x += 1
            when 'L'
              position_x -= 1
            when 'U'
              position_y += 1
            when 'D'
              position_y -= 1
            else
              puts "read error"
              exit -1
            end

            map[[position_x, position_y]] ||= {}
            map[[position_x, position_y]][path_index] = true
          end
        end
      end

      closesed_intersection = map.select{ |_, tracks| tracks[0] && tracks[1] }.min_by { |pos, _| pos[0].abs + pos[1].abs }
      return closesed_intersection[0][0].abs + closesed_intersection[0][1].abs
    end
  end
end
