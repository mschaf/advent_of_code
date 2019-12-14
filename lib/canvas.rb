class Canvas

  attr_accessor :canvas

  def initialize(color_palette: {0 => ' ', 1 => '#'}, initial_color: 0)
    @canvas = {}
    @color_palette = color_palette
    @initial_color = initial_color
  end

  def draw(x, y, color)
    @canvas[[x, y]] = color
  end

  def get_color_at(x, y)
    @canvas[[x, y]] || @initial_color
  end

  def render_to_string
    return '' if @canvas.empty?
    min_x = @canvas.keys.min_by{ |x, _| x }[0]
    max_x = @canvas.keys.max_by{ |x, _| x }[0]
    min_y = @canvas.keys.min_by{ |_, y| y }[1]
    max_y = @canvas.keys.max_by{ |_, y| y }[1]
    canvas_string = ""
    (min_y..max_y).each do |y|
      canvas_string <<  "\n"
      (min_x..max_x).each do |x|
        canvas_string << (@color_palette[get_color_at(x, y)] || ' ')
      end
    end
    canvas_string
  end






end