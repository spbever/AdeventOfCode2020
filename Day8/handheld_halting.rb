class Instruction
  attr_accessor :instruction, :incrementor

  def self.parse_from_string instruction_string
    instruction = instruction_string.split(' ').first
    incrementor = instruction_string[/\d+/].to_i * (instruction_string.include?('-') ? -1 : 1)
    i = Instruction.new 
    i.instruction = instruction
    i.incrementor = incrementor
    i
  end

  def self.parse_instruction_file file_path
    File.readlines(file_path).map do |line|
      Instruction.parse_from_string(line)
    end
  end
end


def process_instruction_file file_path
  c = 0
  accumulator=0
  instructions = Instruction.parse_instruction_file(file_path)

  instructions_processed = []
  current_index = 0
  while true
    break if instructions_processed.include? current_index
    break if current_index < 0 || current_index >= instructions.length
    case instructions[current_index].instruction
    when 'nop'
      current_index +=1
    when 'jmp'
      current_index += instructions[current_index].incrementor
    when 'acc'
      accumulator += instructions[current_index].incrementor
      current_index += 1
    else
      raise "UNKNOWN COMMAND #{instructions[current_index].instruction}"
    end
  end
  
  return current_index, accumulator
end

part_one_last_index, part_one_accumulator = process_instruction_file'./input.txt'
puts "Last instruction index ran on bad instruction set #{part_one_last_index}"
puts "DAY 8 Part 1: Accumulator value at loop start: #{part_one_accumulator}" #1816

part_two_last_index, part_two_accumulator = process_instruction_file'./input_fixed.txt'
puts "Last instruction index ran on fixed instruction set #{part_two_last_index}"
puts "DAY 8 Part 2: Accumulator value at end of program: #{part_two_accumulator}"