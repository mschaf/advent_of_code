module Day13
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)

      canvas = Canvas.new(color_palette: {0 => ' ', 1 => '#', 2 => 'B', 3 => '-', 4 => 'O'})

      computer = IntCodeComputer.new(program)
      computer.run
      computer.output_buffer.each_slice(3) do |x, y, type|
        canvas.draw(x, y, type)
      end

      # puts canvas.render_to_string
      return canvas.canvas.select{ |_, c| c == 2 }.count
    end

  end
end

