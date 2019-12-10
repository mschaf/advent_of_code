class IntCodeComputer

  attr_reader :state
  attr_reader :program_counter
  attr_reader :program
  attr_reader :input
  attr_reader :output
  attr_accessor :debug_level

  def initialize(program)
    @program = program
    @program_counter = 0
    @input = []
    @output = []
    @debug_level = 0
    @relative_base = 0

    @instructions = {}
    private_methods.each do |method|
      if method.to_s.start_with? 'instruction_'
        optcode = method.to_s.split('_')[1].to_i
        @instructions[optcode] = { name: method.to_s.split('_').drop(2).join(' '), method: method }
      end
    end

    set_state :initialized
  end

  def input(value)
    @input << value
  end

  def output
    @output.shift
  end

  def all_outputs
    @output
  end

  def run
    set_state :running
    while @state == :running
      step
    end
  end

  private

  def set_state(state)
    debug "state: #{state}"
    @state = state
  end

  def debug(msg, level: 1)
    puts ("  " * (level-1)) + msg if @debug_level >= level
  end

  def get_parameter_addresses(count, instruction_address: @program_counter)
    instruction = @program[instruction_address] 
    debug "decoding #{count} parameter addresses for #{instruction}(at #{instruction_address})", level: 2
    addresses = []
    (1..count).each do |i|
       mode = (instruction / 10**(i+1)) % 10
       case mode
       when 0
         mode_string = "position"
         address = read_at(instruction_address + i)
       when 1
         mode_string = "immediate"
         address = instruction_address + i
       when 2
         mode_string = "relative"
         address = @relative_base + read_at(instruction_address + i)
       else
         raise "Unknown parameter mode #{mode} for parameter #{i} in instruction #{instruction}(at #{instruction_address})"
       end
       debug "address of #{i}. parameter is #{address} (#{mode_string} mode)", level: 3
       addresses << address
    end
    addresses.one? ? addresses.first : addresses
  end

  def write_at(address, value)
    debug "writing #{value} to #{address}", level: 4
    @program[address] = value
  end

  def read_at(*addresses)
    values = addresses.map do |address|
      value = @program[address] || 0
      debug "reading #{value} at #{address}", level: 4
      value
    end
    values.one? ? values.first : values
  end

  def step
    optcode = @program[@program_counter] % 100
    instruction = @instructions[optcode]
    unless instruction
      raise "Instruction with #{optcode} not found"
    end
    debug("executing #{@program[@program_counter]} (#{instruction[:name]}) at #{@program_counter}", level: 1)
    send(instruction[:method])
  end

  def instruction_1_add
    param_1_address, param_2_address, result_address = get_parameter_addresses(3)
    param_1, param_2 = read_at(param_1_address, param_2_address)
    result = param_1 + param_2
    debug("#{param_1} + #{param_2} = #{result}", level: 2)
    write_at(result_address, result)
    @program_counter += 4
  end

  def instruction_2_multiply
    param_1_address, param_2_address, result_address = get_parameter_addresses(3)
    param_1, param_2 = read_at(param_1_address, param_2_address)
    result = param_1 * param_2
    debug("#{param_1} * #{param_2} = #{result}", level: 2)
    write_at(result_address, result)
    @program_counter += 4
  end


  def instruction_3_input
    if @input.empty?
      debug "no input present: pausing execution"
      set_state :waiting_for_input
    else
      input = @input.shift
      write_address = get_parameter_addresses(1)
      debug "inputting #{input}", level: 2
      write_at write_address, input
      @program_counter += 2
    end
  end

  def instruction_4_output
    output = read_at(*get_parameter_addresses(1))
    debug "outputting #{output}", level: 2
    @output << output
    @program_counter += 2
  end

  def instruction_5_jump_if_true
    param_1, param_2 = read_at(*get_parameter_addresses(2))
    if param_1 != 0
      debug "value #{param_1} is true, jumping to #{param_2}", level: 2
      @program_counter = param_2
    else
      debug "value #{param_1} is false, not jumping", level: 2
      @program_counter += 3
    end
  end

  def instruction_6_jump_if_false
    param_1, param_2 = read_at(*get_parameter_addresses(2))
    if param_1 == 0
      debug "value #{param_1} is false, jumping to #{param_2}", level: 2
      @program_counter = param_2
    else
      debug "value #{param_1} is true, not jumping", level: 2
      @program_counter += 3
    end
  end

  def instruction_7_less_than
    param_1_address, param_2_address, result_address = get_parameter_addresses(3)
    param_1, param_2 = read_at(param_1_address, param_2_address)
    if param_1 < param_2
      debug "#{param_1} is less than #{param_2} -> 1", level: 2
      write_at(result_address, 1)
    else
      debug "#{param_1} is not less than #{param_2} -> 0", level: 2
      write_at(result_address, 0)
    end
    @program_counter += 4
  end

  def instruction_8_equal_to
    param_1_address, param_2_address, result_address = get_parameter_addresses(3)
    param_1, param_2 = read_at(param_1_address, param_2_address)
    if param_1 == param_2
      debug "#{param_1} is equal to #{param_2} -> 1", level: 2
      write_at(result_address, 1)
    else
      debug "#{param_1} is not equal to #{param_2} -> 0", level: 2
      write_at(result_address, 0)
    end
    @program_counter += 4
  end

  def instruction_9_adjust_optcode
    param_1 = read_at(*get_parameter_addresses(1))
    debug "relative base: #{@relative_base} #{param_1 >= 0 ? '+ ' : ''}#{param_1} = #{@relative_base + param_1}", level: 2
    @relative_base += param_1
    @program_counter += 2
  end

  def instruction_99_halt
    set_state :halted
  end

 # while true
 #   optcode = program[program_counter] % 100
 #   case optcode
 #   when 1 # add
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     program[program[program_counter+3]] = param_1 + param_2
 #     program_counter += 4
 #   when 2 # multiply
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     program[program[program_counter+3]] = param_1 * param_2
 #     program_counter += 4
 #   when 3 # input
 #     print "Input: "
 #     program[program[program_counter+1]] = gets.strip.to_i
 #     program_counter += 2
 #   when 4 # output
 #     param_1, _ = get_parameters(program, program_counter, 1)
 #     puts "Output: #{param_1}"
 #     program_counter += 2
 #   when 5 # jump if true
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     if param_1 != 0
 #       program_counter = param_2
 #     else
 #       program_counter += 3
 #     end
 #   when 6 # jump if false
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     if param_1 == 0
 #       program_counter = param_2
 #     else
 #       program_counter += 3
 #     end
 #   when 7 # less than
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     program[program[program_counter+3]] = (param_1 < param_2 ? 1 : 0)
 #     program_counter += 4
 #   when 8 # equals
 #     param_1, param_2 = get_parameters(program, program_counter, 2)
 #     program[program[program_counter+3]] = (param_1 == param_2 ? 1 : 0)
 #     program_counter += 4
 #   when 99
 #     break
 #   else
 #     puts "sth went wrong"
 #     break
 #   end
 #
 # end






end
