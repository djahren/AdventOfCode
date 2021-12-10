with open('d10_input.txt', 'r') as f:
	lines = [j.replace('\n','') for j in f.readlines() if j != '\n']
points = {
	')': 3,
	']': 57,
	'}': 1197,
	'>': 25137
}
expected = {
	'(': ')',
	'[': ']',
	'{': '}',
	'<': '>'
}

def check_line(line):
	#return, True=valid, stack=incomplete, or invalid char
	stack = []
	for char in line:
		if char in expected:
			#opening char: add to stack
			stack.append(char)
		else:
			opening = stack.pop()
			exp = expected[opening]
			if char != exp:
				return char
	if len(stack) == 0:
		return True
	else:
		return stack
		
#part1
# total_points = 0
# for line in lines: 
# 	check = check_line(line)
# 	if check and not isinstance(check, list):
# 		print(line)
# 		print(check)
# 		total_points += points[check]
# print(total_points)

#part2
points = {	')': 1,	']': 2,	'}': 3,	'>': 4}
scores = []
for line in lines: 
	score = 0
	check = check_line(line)
	line += "-"
	if isinstance(check, list): #incomplete line
		while(len(check) > 0):
			char = check.pop()
			exp = expected[char]
			line += exp
			score *= 5
			score += points[exp]
		scores.append(score)
scores.sort()
print(scores[(len(scores)-1)//2]) #find middle
