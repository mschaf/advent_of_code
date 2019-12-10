module Day8
  module Part1

    def self.run(input)
      layers = input.split('').map(&:to_i).each_slice(25*6).to_a
      min_0_layer = layers.min_by{ |layer| layer.count(0) }
      return min_0_layer.count(1) * min_0_layer.count(2)
    end

  end
end

