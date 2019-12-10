module Day2
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)

      program[1] = 12
      program[2] = 2

      computer = IntCodeComputer.new(program)
      computer.run

      return program[0]
    end

  end
end
