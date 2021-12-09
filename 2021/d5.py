from pandas import *
with open('d5_input.txt', 'r', encoding='utf-8') as f:
	lines = [j.replace('\n','') for j in f.readlines() if j != '\n']
point_pairs = []
for line in lines:
    line_split = line.split(' -> ')
    point_pairs.append({
        "start": [int(x) for x in line_split[0].split(',')],
        "end":   [int(x) for x in line_split[1].split(',')]
    })

#part1
valid_pairs = [pair for pair in point_pairs if pair["start"][0] == pair["end"][0] or pair["start"][1] == pair["end"][1]]

#part2
valid_pairs = point_pairs
highest_value = 0
for pair in valid_pairs:
    for part in pair:
        for i in range(2):
            if pair[part][i] > highest_value:
                highest_value = pair[part][i]
highest_value += 1
grid = []
for i in range(highest_value):
    grid.append([])
    for j in range(highest_value):
        grid[i].append('.')

# print(highest_value)
print(DataFrame(grid))
# print(valid_pairs)

def get_line_points(line):
    index = line['start'].copy()
    points = [line['start']]
    while index != line['end']:
        add = [0,0]
        for i in range(2):
            if index[i] < line['end'][i]: add[i] = 1
            if index[i] > line['end'][i]: add[i] = -1
        for i in range(2):
            index[i] += add[i]
        points.append(index.copy())
    return points
    
# print(get_line_points({'start': [0, 9], 'end': [5, 9]}))
# print(get_line_points({'start': [0, 8], 'end': [8, 0]}))

for line in valid_pairs:
    points = get_line_points(line)
    for (x, y) in points:
        # print((x,y))
        if grid[y][x] == '.':
            grid[y][x] = 1
        else:
            grid[y][x] += 1
print(DataFrame(grid))
grid_str = ""
for row in grid: 
    grid_str += "".join([str(c) for c in row])
print(len(grid_str.replace('.','').replace('1','')))