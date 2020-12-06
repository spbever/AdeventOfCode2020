raw_input = File.read('./input.txt')
customs_groups = raw_input.split(/\n{2,}/)

def group_shared_answers group_text
  individual_answers = group_text.split("\n").map { |individual| individual.split('') }
  common_answers = nil
  while individual_answers.count > 0
    if common_answers == nil
      common_answers = individual_answers.pop
    else
      common_answers = (common_answers & individual_answers.pop)
    end
  end
  common_answers
end

def group_all_answers group_text
  group_text.gsub("\n",'').split('').uniq
end

group_total_answers = []
group_common_answers = []

customs_groups.each do |customs_group|
  group_total_answers << group_all_answers(customs_group)
  group_common_answers << group_shared_answers(customs_group)
end


puts "Day 6 Part 1: Total group questions answered yes - #{group_total_answers.map(&:count).sum}" #6612
puts "Day 6 Part 2: Total group questions all answered yes - #{group_common_answers.map(&:count).sum}" #3268
