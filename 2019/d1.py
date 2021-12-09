import math
f = open("d1input.txt", "r")
sum = 0

def calculate_fuel(mass):
	result = math.floor(mass / 3) - 2
	if(result >= 0):
		result += calculate_fuel(result)
		return result
	else:
		return 0

for line in f.readlines():
	result = calculate_fuel(int(line))
	sum += result

print(sum)




