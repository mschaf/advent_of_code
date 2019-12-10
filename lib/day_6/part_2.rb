module Day6
  module Part2

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

      queue = nodes.values.clone
      nodes['YOU'].distance = 0

      until queue.empty?
        node = queue.select(&:distance).min_by(&:distance)
        queue.delete(node)

        node.neighbours.each do |neighbour|
          new_distance = node.distance + 1
          if !neighbour.distance || new_distance < neighbour.distance
            neighbour.distance = new_distance
            neighbour.previous = node
          end
        end
      end

      return nodes['SAN'].distance - 2
    end
  end
end
