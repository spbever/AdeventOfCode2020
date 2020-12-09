COLOR_CODED_BAGS = {}
data = File.readlines('./input.txt')

data.each do |rule|
  rule_contains = rule.gsub('.','').gsub('bags','').gsub('bag', '').split('contain')
  rule = rule_contains.first.strip
  COLOR_CODED_BAGS[rule] = {}

  rule_contains.last.split(',').each do |contain|
    next if contain.include?("no other")
    amount = contain.to_i
    amount ||= 1
    color = contain.gsub(/\d/, '').strip
    COLOR_CODED_BAGS[rule][color] = amount
  end
end



def can_bag_contain_color bag, search_color, stop_list=[]
  return false if stop_list.include? bag
  return true if COLOR_CODED_BAGS[bag].include? search_color
  COLOR_CODED_BAGS[bag].keys.any? {|bagg| can_bag_contain_color(bagg, search_color, stop_list)}
end

def how_many_inner_bags outer_bag
  total = 0
  return total if COLOR_CODED_BAGS[outer_bag].keys.count == 0
  COLOR_CODED_BAGS[outer_bag].each do |inner_bag, count|
    total += count
    total += (count * how_many_inner_bags(inner_bag))
  end
  total
end

search_color = 'shiny gold'
count_that_can_contain = 0
COLOR_CODED_BAGS.keys.each do |bag_color|
  count_that_can_contain +=1 if can_bag_contain_color bag_color, search_color
end

puts "DAY 7 Part 1: There are #{count_that_can_contain} bags that can contain a #{search_color} bag"
puts "DAY 7 Part 2: A #{search_color} bag must contain #{how_many_inner_bags(search_color)} other bags"

