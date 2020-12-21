FLOOR="."
EMPTY_SEAT="L"
OCCUPIED_SEAT="#"

PART_1_EXPECTED_TEST_RESULT=37


test_start_seating_chart = File.readlines('./test_input.txt').collect{|row| row.gsub(/\s/, '').split('')}
updated_test_chart = []

starting_seating_chart = File.readlines('./input.txt').collect{|row| row.gsub(/\s/, '').split('')}
updated_seating_chart = []

def process_seating_chart starting_chart
  new_seating_chart = []
  starting_chart.each_index do |row|
    starting_chart[row].each_index do |column|
      process_seat starting_chart, new_seating_chart, column, row
    end
  end
  new_seating_chart
end

def process_seat starting_chart, updated_chart, column, row
  updated_chart[row] = [] if updated_chart[row].nil?
  seat = starting_chart[row][column]
  occupied_adjacent_seats = seat_adjacency_count starting_chart, column, row
  if seat == FLOOR
    updated_chart[row][column] = FLOOR
  elsif seat == EMPTY_SEAT && occupied_adjacent_seats == 0
    updated_chart[row][column] = OCCUPIED_SEAT
  elsif seat == OCCUPIED_SEAT && occupied_adjacent_seats >= 4
    updated_chart[row][column] = EMPTY_SEAT
  else
    updated_chart[row][column] = seat
  end
end


def seat_adjacency_count seating_chart, column, row
  adjacency_count = 0
  adjacency_count += 1 if row > 0 && column > 0 && seating_chart[row-1][column-1] == OCCUPIED_SEAT
  adjacency_count += 1 if row > 0 && seating_chart[row-1][column] == OCCUPIED_SEAT
  adjacency_count += 1 if row > 0 && column + 1 < seating_chart[row].length && seating_chart[row-1][column+1] == OCCUPIED_SEAT

  adjacency_count += 1 if column > 0 && seating_chart[row][column-1] == OCCUPIED_SEAT
  adjacency_count += 1 if column + 1 < seating_chart[row].length && seating_chart[row][column+1] == OCCUPIED_SEAT

  adjacency_count += 1 if row + 1 < seating_chart.length && column > 0 &&  seating_chart[row+1][column] == OCCUPIED_SEAT
  adjacency_count += 1 if row + 1 < seating_chart.length && seating_chart[row+1][column-1] == OCCUPIED_SEAT
  adjacency_count += 1 if row + 1 < seating_chart.length && column + 1 < seating_chart[row+1].length && seating_chart[row+1][column+1] == OCCUPIED_SEAT

  adjacency_count
end

def seating_charts_match? seating_chart_a, seating_chart_b
  return false if seating_chart_a.length != seating_chart_b.length
  seating_chart_a.each_index do |row|
    return false if seating_chart_a[row].length != seating_chart_b[row].length
    seating_chart_a[row].each_index do |column|
      return false if seating_chart_a[row][column] != seating_chart_b[row][column]
    end
  end
  true
end


while true do
  updated_test_chart = process_seating_chart test_start_seating_chart
  break if seating_charts_match? test_start_seating_chart, updated_test_chart
  test_start_seating_chart = updated_test_chart
end

occupied_test_seats = test_start_seating_chart.collect{|row|row.join('')}.join('').count OCCUPIED_SEAT
raise 'Script did not come up with expected test value' unless occupied_test_seats == PART_1_EXPECTED_TEST_RESULT

while true do
  updated_seating_chart = process_seating_chart starting_seating_chart
  break if seating_charts_match? starting_seating_chart, updated_seating_chart
  starting_seating_chart = updated_seating_chart
end

occupied_seats = starting_seating_chart.collect{|row|row.join('')}.join('').count OCCUPIED_SEAT


#2328 too high

puts "Day 11 part 1: Final occupied seat count: #{occupied_seats}"

puts '-----------------------------------------------'
starting_seating_chart.each{|r|p r.join('')}
puts '-----------------------------------------------'
updated_seating_chart.each{|r|p r.join('')}
puts '-----------------------------------------------'

