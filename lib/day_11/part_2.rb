module Day11
  module Part2

    def self.run(input)
      program = input.split(',').map(&:to_i)
      paint_roboter = PaintRoboter.new(program, initial_canvas_color: 1)
      paint_roboter.run
      return paint_roboter.render_canvas
    end

  end
end

