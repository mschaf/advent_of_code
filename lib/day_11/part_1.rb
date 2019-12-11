module Day11
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)
      paint_roboter = PaintRoboter.new(program)
      paint_roboter.run
      return paint_roboter.canvas.count
    end

  end
end

