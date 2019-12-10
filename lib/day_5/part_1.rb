module Day5
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)

      computer = IntCodeComputer.new(program)
      computer.input(1)
      computer.run

      output = 0
      until output != 0
        output = computer.output
      end

      return output
    end

  end
end