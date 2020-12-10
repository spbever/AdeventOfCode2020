number_list = File.readlines('./input.txt').collect(&:to_i)
preamble = 25

starting_index = 25

def check_number number_to_check, array_of_possiblities
  length = array_of_possiblities.length
  array_of_possiblities.each_with_index do |value, index|
    second_index = index + 1
    break if second_index >= length
    while second_index < length
      return true if array_of_possiblities[second_index] + value == number_to_check
      second_index += 1
    end
  end
  false
end

def find_range_that_sums_to value_to_check, array_of_posibilites
  starting_index = 0
  ending_index = 1
  found_range = false
  while starting_index < (array_of_posibilites.length - 1) && !found_range
    while ending_index < array_of_posibilites.length
      sum = array_of_posibilites[starting_index..ending_index].sum
      if array_of_posibilites[starting_index..ending_index].sum == value_to_check
        found_range = true
        break
      elsif sum > value_to_check
        starting_index += 1
        ending_index = starting_index + 1
        break
      else
        ending_index += 1
      end
    end
  end
  return found_range, starting_index, ending_index
end

first_failed_value = nil
while starting_index < number_list.length
  unless check_number number_list[starting_index], number_list[starting_index - preamble .. starting_index - 1]
    first_failed_value = number_list[starting_index]
    break
  end
  starting_index += 1
end

puts "Day 9 Part 1: First failed value is #{first_failed_value}"

valid_range_found, starting_index, ending_index = find_range_that_sums_to(first_failed_value, number_list)
if valid_range_found
  puts "Day 9 Part 2: the valid range is from #{starting_index} to #{ending_index} and the sum of the largest and smallest numbers in that range is #{number_list[starting_index..ending_index].min + number_list[starting_index..ending_index].max}"
else
  puts "Day 9 Part 2: No range found."
end