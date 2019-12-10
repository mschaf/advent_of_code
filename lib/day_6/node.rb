module Day6
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
end