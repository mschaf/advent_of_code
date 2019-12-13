module Day12
  class Moon

    attr_accessor :position
    attr_accessor :velocity

    def initialize(x: 0, y: 0, z: 0)
      @position = x, y, z
      @velocity = 0, 0 ,0
    end

    def apply_gravity(other_moon)
      (0..2).each do |axis|
        @velocity[axis] += other_moon.position[axis] <=> @position[axis]
      end
    end

    def apply_velocity
      (0..2).each do |axis|
        @position[axis] += @velocity[axis]
      end
    end

    def energy
      @position.map(&:abs).sum * @velocity.map(&:abs).sum
    end

    def self.from_input(input)
      position =  input.match(/<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/).named_captures
      position = position.transform_keys(&:to_sym).transform_values(&:to_i)
      self.new(position)
    end

  end
end