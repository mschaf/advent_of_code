module Day12
  module Part1

    def self.run(input)
      moons = []
      input.each_line do |line|
        moons << Moon.from_input(line)
      end

      steps = 1000

      history = []

      (0...steps).each do |step|
        moons.each do |moon|
          (moons - [moon]).each do |other_moon|
            moon.apply_gravity(other_moon)
          end
        end

        moons.each do |moon|
          moon.apply_velocity
        end
      end

      return moons.map(&:energy).sum
    end

  end
end

