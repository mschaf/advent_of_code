module Day9
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)
      computer = IntCodeComputer.new(program)
      computer.input 1
      computer.run
      return computer.output
    end

  end
end

