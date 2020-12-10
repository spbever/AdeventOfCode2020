adapters = File.readlines('./input.txt').collect { |adapter| adapter.to_i }
sorted_adapters = adapters.sort

sorted_adapters.unshift(0) unless sorted_adapters.first == 0
sorted_adapters << sorted_adapters.last + 3

number_of_1_gap_differencs = 0
number_of_3_gap_differencs = 0
possible_connection_list = []

sorted_adapters.each_with_index do |adapter, index|
  total_possible_connections = 0
  total_possible_connections += 1 if index - 1 >= 0 &&  adapter - sorted_adapters[index - 1] <= 3
  total_possible_connections += 1 if index - 2 >= 0 && adapter - sorted_adapters[index - 2] <= 3
  total_possible_connections += 1 if index - 3 >= 0 && adapter - sorted_adapters[index - 3] <= 3
  possible_connection_list << total_possible_connections

  if index + 1 == sorted_adapters.length
    break
  end

  case sorted_adapters[index+1] - adapter
  when 1
    number_of_1_gap_differencs +=1
  when 3
    number_of_3_gap_differencs +=1
  end
end


puts "Day 10 Part 1: #{number_of_1_gap_differencs * number_of_3_gap_differencs}" #1920

# reddit solution
# counts = [0] * nums.size
# children = -> (val) {
#   nums.each_index.select { |idx| val < nums[idx] && nums[idx] <= val+3 }
# }
# (nums.size-1).downto(0) do |i|
#   c = children.call(nums[i])
#   counts[i] = [1, counts.values_at(*c).sum].max
# end
# p possible_connection_list.sum


# My Solution
calculated_direct_paths_to = []
check_list = sorted_adapters[1..-2]

check_list.each_with_index do |adapter, index|
  if index == 0
    calculated_direct_paths_to << index + 1
  else
    t = 0
    t += 1 if adapter - check_list[index-1] <= 3
    t += 1 if adapter - check_list[index-2] <= 3
    t += 1 if adapter - check_list[index-3] <= 3
    calculated_direct_paths_to << t
  end
end

paths_to_point = []

calculated_direct_paths_to.each_with_index do |direct_paths, index|
  if index == 0
  paths_to_point << 1
  else
    paths_to_point << paths_to_point.values_at(*[([index-direct_paths, 0].max)..index-1]).sum
  end
end

paths_to_last_point = paths_to_point.last
# expected = 1511207993344
# puts "Expected Total: #{expected}"
# puts "Calculated Total: #{paths_to_last_point}"
# puts "Difference: #{expected - paths_to_last_point}"
puts "Day 10 Part 2: Total possible paths #{paths_to_last_point}"
