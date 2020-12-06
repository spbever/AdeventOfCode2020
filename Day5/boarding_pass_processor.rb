ROWS=(0..127).to_a
SEATS=(0..7).to_a

boarding_passes_input = File.readlines('./input.txt').map {|line| line.gsub("\n", '')}

def process_row boarding_pass_input, row_type=:row
  processed_row = row_type == :row ? ROWS : SEATS

  boarding_pass_input.split('').each do |direction|
    break if processed_row.count < 2
    direction_method = direction.downcase.to_sym == :f  || direction.downcase.to_sym == :l ? :first : :last
    mid_point = processed_row.count / 2
    if direction_method == :first
      processed_row = processed_row[0..mid_point-1]
    else
      processed_row = processed_row[mid_point..-1]
    end
  end
  processed_row.first
end

def position_id_from_row_and_seat row_id, seat_id
  (row_id * 8) + seat_id
end

position_ids = []

boarding_passes_input.each do |boarding_pass_input|
  row_directions = boarding_pass_input[0..6]
  seat_directions = boarding_pass_input[7..-1]
  position_ids << position_id_from_row_and_seat(process_row(row_directions), process_row(seat_directions, :seat))
end
position_ids.sort!
max_position_id = position_ids.last

missing_position_id = nil
position_ids.each_with_index do |position_id, index|
  if position_ids[index+1] - position_id == 2
    missing_position_id = position_id + 1
    break
  end
end

puts "Day 5 Part 1: Max seat id is #{max_position_id}"
puts "Day 5 Part 2: My seat id is #{missing_position_id}"