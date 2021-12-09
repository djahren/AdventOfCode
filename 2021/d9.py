from numpy.core.fromnumeric import product
from pandas import *
with open('d9_input.txt', 'r') as f:
	lines = [j.replace('\n','') for j in f.readlines() if j != '\n']
width = len(lines[0])
height = len(lines)
# print(lines[0][0])

grid = [[-1 for i in range(width)] for j in range(height)]
# print(DataFrame(grid))

#populate grid
for h in range(height):
    for w in range(width):
        grid[h][w] = int(lines[h][w])
print(DataFrame(grid))

def check_low_point(y,x):
    value = grid[y][x]
    up = value + 1 if y-1 < 0 else grid[y-1][x]
    down = value + 1 if y+1 >= height else grid[y+1][x]
    left = value + 1 if x-1 < 0 else grid[y][x-1]
    right = value + 1 if x+1 >= width else grid[y][x+1]

    if value < up and value < down and value < left and value < right:
        return value
    else:
        return -1

#part1
# low_points = []
# for y in range(height):
#     for x in range(width):
#         if check_low_point(y,x) != -1: 
#             low_points.append(grid[y][x])
# print(low_points)
# risk_levels = [lp + 1 for lp in low_points]
# print(risk_levels)
# risk_sum = sum(risk_levels)
# print(f"Risk Sum: {risk_sum}")

#part2

# count = 0

# def find_basin(y,x, input_basin = []): #v1
#     basin = input_basin + [(y,x)]
#     # print(basin)

#     # global count 
#     # count += 1
#     # if count > 10:
#     #     return []

#     #up
#     if y-1 >= 0:
#         if grid[y-1][x] < 9 and (y-1,x) not in basin:
#             # print(f"going up from y{y}x{x}")
#             basin += find_basin(y-1,x, basin)
#     #down
#     if y+1 < height:
#         if grid[y+1][x] < 9 and (y+1,x) not in basin:
#             # print(f"going down from y{y}x{x}")            
#             basin += find_basin(y+1,x, basin)
#     #left
#     if x-1 >= 0:
#         if grid[y][x-1] < 9 and (y,x-1) not in basin:
#             # print(f"going left from y{y}x{x}")  
#             basin += find_basin(y,x-1, basin)
#     #right
#     if x+1 < width:
#         if grid[y][x+1] < 9 and (y,x+1) not in basin:
#             # print(f"going right from y{y}x{x}")  
#             basin += find_basin(y,x+1, basin)
#     return basin

current_basin = []
def find_basin(y,x):
    global current_basin
    current_basin += [(y,x)]

    #up
    if y-1 >= 0:
        if grid[y-1][x] < 9 and (y-1,x) not in current_basin:
            # print(f"going up from y{y}x{x}")
            find_basin(y-1,x)
    #down
    if y+1 < height:
        if grid[y+1][x] < 9 and (y+1,x) not in current_basin:
            # print(f"going down from y{y}x{x}")            
            find_basin(y+1,x)
    #left
    if x-1 >= 0:
        if grid[y][x-1] < 9 and (y,x-1) not in current_basin:
            # print(f"going left from y{y}x{x}")  
            find_basin(y,x-1)
    #right
    if x+1 < width:
        if grid[y][x+1] < 9 and (y,x+1) not in current_basin:
            # print(f"going right from y{y}x{x}")  
            find_basin(y,x+1)
# find_basin(0,9)
# print(current_basin)

def remove_dupes(input_arr):
    new_arr = []
    for item in input_arr:
        if item not in new_arr:
            new_arr.append(item)
    return new_arr

basins = []
low_points = []
for y in range(height):
    for x in range(width):
        if check_low_point(y,x) != -1: 
            print(f"Low point found at ({y},{x})")
            low_points.append(grid[y][x])
            current_basin = []
            find_basin(y,x)
            basins.append(len(current_basin))
print(basins)
basins.sort()
print(basins)
top_3 = basins[-3:]
print(product(basins[-3:]))