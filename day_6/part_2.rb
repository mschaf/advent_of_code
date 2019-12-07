require 'byebug'

class Node
  attr_accessor :name
  attr_accessor :orbits
  attr_accessor :orbiter

  attr_accessor :previous
  attr_accessor :distance

  def initialize(name)
    @name = name
    @orbiter = []
  end

  def distance_to_center
    orbits&.distance_to_center&.+(1) || 0
  end

  def neighbours
    orbiter.append(orbits).compact
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

puts nodes['SAN'].distance - 2
