values = File.read("input.txt").each_line.map(&:to_i)
puts values.map{|v| (v/3).floor - 2 }.sum