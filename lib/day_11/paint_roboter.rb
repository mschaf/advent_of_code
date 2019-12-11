module Day11
  class PaintRoboter

    attr_reader :canvas
    attr_reader :computer

    def initialize(program, initial_canvas_color: 0)
      @computer = IntCodeComputer.new(program)
      @direction = :up
      @position = 0, 0
      @canvas = Hash.new
      @initial_canvas_color = initial_canvas_color
    end

    def step
      @computer.input(@canvas[@position] || @initial_canvas_color)
      @computer.run
      @canvas[@position.clone] = @computer.output
      turn_direction = @computer.output
      case turn_direction
      when 0
        turn_left
      when 1
        turn_right
      end
      move
    end

    def run
      until @computer.state == :halted
        step
      end
    end

    def render_canvas
      min_x = @canvas.keys.min_by{ |x, _| x }[0]
      max_x = @canvas.keys.max_by{ |x, _| x }[0]
      min_y = @canvas.keys.min_by{ |_, y| y }[1]
      max_y = @canvas.keys.max_by{ |_, y| y }[1]
      canvas_string = ""
      (min_y..max_y).each do |y|
        canvas_string <<  "\n"
        (min_x..max_x).each do |x|
          canvas_string << (@canvas[[x,y]] == @initial_canvas_color ? '#' : ' ')
        end
      end
      canvas_string
    end
    private

    def turn_right
      turn_map = {up: :right, right: :down, down: :left, left: :up }
      @direction = turn_map[@direction]
    end

    def turn_left
      3.times { turn_right }
    end

    def move
      case @direction
      when :up
        @position[1] -= 1
      when :right
        @position[0] += 1
      when :down
        @position[1] += 1
      when :left
        @position[0] -= 1
      end
    end

  end

end

