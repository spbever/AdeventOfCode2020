raw_input = File.read('../input.txt')
passports = raw_input.split(/\n{2,}/)

REQUIRED_KEYS = [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]
VALID_EYE_COLORS = [:amb, :blu, :brn, :gry, :grn, :hzl, :oth]

KEY_VALIDATORS = {
	byr: -> (data) {data.to_i >= 1920 && data.to_i <= 2002},
	iyr: -> (data) {data.to_i >= 2010 && data.to_i <= 2020},
	eyr: -> (data) {data.to_i >= 2020 && data.to_i <= 2030},
	hgt: -> (data) { if data.include?('cm')
						data.to_i >= 150 && data.to_i <= 193
					elsif data.include?('in')
						data.to_i >= 59 && data.to_i <= 76
					else
						false
					end
				 },
	hcl: -> (data) {!(data =~ /^#[0-9a-f]{6}$/).nil?},
	ecl: -> (data) {VALID_EYE_COLORS.include?(data.to_sym)},
	pid: -> (data) {!(data =~ /^[0-9]{9}$/).nil?}
}

def process_passport_keys passport_string
	passport_data = {}
	passport_string.split("\s").each{|passport_info| 
		parts = passport_info.split(':')
		passport_data[parts.first.to_sym] = parts.last
	}
	passport_data
end

def includes_all_required_keys? passport_data
	(REQUIRED_KEYS - passport_data.keys).length == 0
end

def all_fields_valid? passport_data
	includes_all_required_keys?(passport_data) &&
		KEY_VALIDATORS.all? { |key, validator| validator.call(passport_data[key]) }
end

total_processed = 0
valid_passports = 0
passports_with_valid_data = 0

passports.each do |passport|
	total_processed += 1
	passport_data = process_passport_keys passport
	valid_passports += 1 if includes_all_required_keys? passport_data
	passports_with_valid_data += 1 if all_fields_valid? passport_data
end

puts "(Part 1) #{valid_passports} passports with required keys of #{total_processed} passports processed." #256
puts "(Part 2) #{passports_with_valid_data} passports with valid data of #{total_processed} passports processed." #198
