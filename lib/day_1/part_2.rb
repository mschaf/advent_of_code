module Day1
  module Part2

    def self.run(input)
      values = input.each_line.map(&:to_i)
      values.map{|v| fuel(v) }.sum
    end

    private

    def self.fuel(weight)
      fuel = (weight/3).floor - 2
      fuel <= 0 ? 0 : fuel + fuel(fuel)
    end

  end
end

