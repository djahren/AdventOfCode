from pandas import DataFrame
import os
from time import sleep
from colorama import init,Fore, Back, Style
init()

octopi = []
with open('d11_input.txt', 'r') as f:
	lines = [j[:-1] for j in f.readlines() if j != '\n']
	for l in lines:
		octopi.append(list(map(int,l)))

neighbors = [(-1,-1),(-1,0),(-1,1),(0,1),(1,1),(1,0),(1,-1),(0,-1)]

def need_to_flash():
	for row in octopi:
		for f in filter(lambda n: n > 9, row):
			return True
	return False

colors = {
	0: Back.WHITE,
	1: Back.LIGHTRED_EX,
	2: Back.YELLOW,
	3: Back.LIGHTMAGENTA_EX,
	4: Back.LIGHTGREEN_EX,
	5: Back.GREEN,
	6: Back.CYAN,
	7: Back.BLUE,
	8: Back.MAGENTA,
	9: Back.RED,
}
def clear_and_print():
	os.system('cls')
	# print(DataFrame(octopi))
	pretty = ""
	for row in octopi:
		for pi in row:
			pretty += colors[pi] + str(pi)
		pretty += "\n"
	print(pretty + Back.RESET, end='') 

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
#part2
def simultaneous_flashed():
	for row in octopi:
		if sum(row) > 0: 
			return False
	return True

count = 0

#part1
while not simultaneous_flashed():
	count += 1
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
	print(count,'/?', sep='')
	sleep(.2)


