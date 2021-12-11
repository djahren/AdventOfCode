from pandas import DataFrame
import os
from time import sleep

octopi = []
with open('d11_testinput.txt', 'r') as f:
	lines = [j[:-1] for j in f.readlines() if j != '\n']
	for l in lines:
		octopi.append(list(map(int,l)))

neighbors = [(-1,-1),(-1,0),(-1,1),(0,1),(1,1),(1,0),(1,-1),(0,-1)]

def need_to_flash():
	for row in octopi:
		for f in filter(lambda n: n > 9, row):
			return True
	return False

def clear_and_print():
	os.system('cls')
	print(DataFrame(octopi))

flashed = []; total_flashes = 0
def flash(y,x):
	flashed.append((y,x))
	global total_flashes
	total_flashes += 1
	octopi[y][x] = 0
	for (a,b) in neighbors:
		if 0 <= y+a < len(octopi) and 0 <= x+b < len(octopi[0]):
			octopi[y+a][x+b] += 1
			if octopi[y+a][x+b] > 9:
				flash(y+a,x+b)

#part1
for i in range(100):
	flashed = []
	for row in range(len(octopi)): 
		octopi[row] = [r + 1 for r in octopi[row]]
	while need_to_flash():
		for y,row in enumerate(octopi):
			for x,col in enumerate(row):
				if octopi[y][x] > 9: #do the flash!
					flash(y, x)
	for (y,x) in flashed:
		octopi[y][x] = 0
	clear_and_print()
	print(i+1,'/100', sep='')
	sleep(.1)
print(total_flashes)

#part2
