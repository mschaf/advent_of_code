module Day2
  module Part2

    def self.run(input)

      (0..99).each do |noun|
        (0..99).each do |verb|

          program = input.split(',').map(&:to_i)

          program[1] = noun
          program[2] = verb

          computer = IntCodeComputer.new(program)
          computer.run

          if program[0] == 19690720
            return 100 * noun + verb
          end

        end
      end
    end

  end
end

