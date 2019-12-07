class Node
  attr_accessor :name
  attr_accessor :orbits
  attr_accessor :orbiter

  def initialize(name)
    @name = name
    @orbiter = []
  end

  def distance_to_center
    orbits&.distance_to_center&.+(1) || 0
  end
end

orbit_data = File.read('input.txt')
nodes = {}

orbit_data.each_line do |orbit|
  center_planet, orbiter_planet = orbit.strip.split(')')

  nodes[center_planet] ||= Node.new(center_planet)
  nodes[orbiter_planet] ||= Node.new(orbiter_planet)

  nodes[center_planet].orbiter << (nodes[orbiter_planet])
  nodes[orbiter_planet].orbits = (nodes[center_planet])
end

puts nodes.sum{ |_, node| node.distance_to_center }

