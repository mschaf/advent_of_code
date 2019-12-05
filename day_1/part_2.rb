values = File.read("input.txt").each_line.map(&:to_i)

def fuel(weight)
  fuel = (weight/3).floor - 2
  fuel <= 0 ? 0 : fuel + fuel(fuel)
end

puts values.map{|v| fuel(v) }.sum