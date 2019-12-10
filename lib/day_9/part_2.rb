module Day9
  module Part2

    def self.run(input)
      program = input.split(',').map(&:to_i)
      computer = IntCodeComputer.new(program)
      computer.input 2
      computer.run
      return computer.output
    end

  end
end

