input = File.read('input.txt').strip

(0..99).each do |noun|
  (0..99).each do |verb|

    program = input.split(',').map(&:to_i)

    program[1] = noun
    program[2] = verb

    program_counter = 0

    while program[program_counter] != 99
      case program[program_counter]
      when 1
        program[program[program_counter+3]] = program[program[program_counter+1]] + program[program[program_counter+2]]
      when 2
        program[program[program_counter+3]] = program[program[program_counter+1]] * program[program[program_counter+2]]
      else
        puts "sth went wrong"
        break
      end
      program_counter += 4
    end

    if program[0] == 19690720
      puts 100 * noun + verb
      # puts program.join(',')
      exit 0
    end

  end
end

