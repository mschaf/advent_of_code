module Day13
  module Part2

    def self.run(input)
      program = input.split(',').map(&:to_i)

      canvas = Canvas.new(color_palette: {0 => ' ', 1 => '#', 2 => 'B', 3 => '-', 4 => 'O'})

      program[0] = 2
      computer = IntCodeComputer.new(program)
      score = nil

      while computer.state != :halted
        computer.step
        while computer.output_buffer.count >= 3
          canvas.draw(computer.output, computer.output, computer.output)
          score = canvas.canvas[[-1, 0]]

          # puts canvas.render_to_string
          # puts "score: #{score}"
        end

        if computer.state == :waiting_for_input
          ball_x = canvas.canvas.find{ |_, v| v == 4 }&.[](0)&.[](0)
          board_x = canvas.canvas.find{ |_, v| v == 3 }&.[](0)&.[](0)

          if ball_x && board_x
            computer.input(ball_x <=> board_x )
          else
            computer.input 0
          end
        end
      end

      return score
    end

  end
end

