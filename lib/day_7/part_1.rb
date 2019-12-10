module Day7
  module Part1

    def self.run(input)
      program = input.split(',').map(&:to_i)

      max_thrust = 0
      (0..4).to_a.permutation.each do |permutation|
        current_output = 0
        (0..4).each do |i|

          computer = IntCodeComputer.new(program.clone)
          computer.input permutation[i]
          computer.input current_output
          computer.run
          current_output = computer.output
        end
        if current_output > max_thrust
          max_thrust = current_output
        end
      end

      return max_thrust
    end

  end
end

