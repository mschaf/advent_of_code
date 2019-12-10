module Day6
  module Part1

    def self.run(input)
      orbit_data = input
      nodes = {}

      orbit_data.each_line do |orbit|
        center_planet, orbiter_planet = orbit.strip.split(')')

        nodes[center_planet] ||= Node.new(center_planet)
        nodes[orbiter_planet] ||= Node.new(orbiter_planet)

        nodes[center_planet].orbiter << (nodes[orbiter_planet])
        nodes[orbiter_planet].orbits = (nodes[center_planet])
      end

      return nodes.sum{ |_, node| node.distance_to_center }
    end

  end
end
