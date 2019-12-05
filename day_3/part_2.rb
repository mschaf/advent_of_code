paths = File.read('input.txt').each_line
map = {}

paths.each_with_index do |path, path_index|
  position_x = 0
  position_y = 0
  steps = 0
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

      steps += 1

      map[[position_x, position_y]] ||= {}
      map[[position_x, position_y]][path_index] = steps
    end
  end
end

closesed_intersection = map.select{ |_, tracks| tracks[0] && tracks[1] }.min_by { |pos, tracks| tracks[0] + tracks[1] }
puts closesed_intersection[1][0] + closesed_intersection[1][1]