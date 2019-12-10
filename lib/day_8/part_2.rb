module Day8
  module Part2

    def self.run(input)
      layers = input.split('').map(&:to_i).each_slice(25*6).to_a
      zipped = layers[0].zip(*layers[1..-1])
      consolidated = zipped.map{ |pixel| (pixel - [2]).first }
      final_image = consolidated.map{ |pixel| pixel == 1 ? '#' : ' ' }
      image_string = ""
      final_image.each_slice(25) do |line|
        image_string << "\n" + line.join('')
      end
      return image_string
    end

  end
end

