module Day1
  module Part1

    def self.run(input)
      values = input.each_line.map(&:to_i)
      values.map{|v| (v/3).floor - 2 }.sum
    end

  end
end

