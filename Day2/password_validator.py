import re
def passwordValidatorPolicy1(minCount, maxCount, match, testString):
	actualCount = len(re.findall(match, testString))
	return actualCount >= minCount and actualCount <= maxCount	

def passwordValidatorPolicy2(firstLocation, secondLocation, match, testString):
	firstLocationMatch = testString[firstLocation-1] == match
	secondLocationMatch = testString[secondLocation-1] == match
	return firstLocationMatch != secondLocationMatch

def parseInputLine(line):
	digits = re.findall('\d+', line)
	firstNumber = int(digits[0])
	secondNumber = int(digits[1])
	match = re.search('[A-Za-z]+', line).group(0)
	password = line.split(':', 1)[1].strip() 
	return firstNumber, secondNumber, match, password

def processInputLinePolicy1(line):
	minCount, maxCount, match, password = parseInputLine(line)
	isValid = passwordValidatorPolicy1(minCount, maxCount, match, password)
	return isValid

def processInputLinePolicy2(line):
	firstLocation, secondLocation, match, password = parseInputLine(line)
	isValid = passwordValidatorPolicy2(firstLocation, secondLocation, match, password)
	return isValid

with open('./input.txt') as f:
    lines = [line.rstrip() for line in f]

validCountPolicy1 = 0
validCountPolicy2 = 0

for line in lines:
	if processInputLinePolicy1(line):
		validCountPolicy1 += 1
	if processInputLinePolicy2(line):
		validCountPolicy2 += 1

print "Valid with Policy 1: " + str(validCountPolicy1)
print "Valid with Policy 2: " + str(validCountPolicy2)