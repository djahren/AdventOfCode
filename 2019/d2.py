d = "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,19,5,23,2,10,23,27,2,27,13,31,1,10,31,35,1,35," \
       "9,39,2,39,13,43,1,43,5,47,1,47,6,51,2,6,51,55,1,5,55,59,2,9,59,63,2,6,63,67,1,13,67,71,1" \
       ",9,71,75,2,13,75,79,1,79,10,83,2,83,9,87,1,5,87,91,2,91,6,95,2,13,95,99,1,99,5,103,1,103," \
       "2,107,1,107,10,0,99,2,0,14,0"
goal = 19690720


def computer(data, noun, verb):
    memory = data.split(",")
    for x in range(len(memory)):
        memory[x] = int(memory[x])  # convert to ints

    memory[1] = noun  # noun
    memory[2] = verb  # verb

    index = 0
    # print(memory)
    while index < len(memory):
        current_datum = memory[index]
        # print(f"Code: {current_datum}")
        if current_datum == 1:
            #    print(f"{memory[index + 1]}:{memory[memory[index + 1]]} + "
            #          f"{memory[index + 2]}:{memory[memory[index + 2]]} saved to {memory[index + 3]}")
            memory[memory[index + 3]] = memory[memory[index + 1]] + memory[memory[index + 2]]
            index += 4
        elif current_datum == 2:
            #    print(f"{memory[index + 1]}:{memory[memory[index + 1]]} * "
            #          f"{memory[index + 2]}:{memory[memory[index + 2]]} saved to {memory[index + 3]}")

            memory[memory[index + 3]] = memory[memory[index + 1]] * memory[memory[index + 2]]
            index += 4
        elif current_datum == 99:
            break
        else:
            index += 1
    return memory[0]


# print(computer(d, 12, 2))

for n in range(100):
    output = None
    for v in range(100):
        output = computer(d, n, v)
        print(f"Noun: {n} Verb: {v} Output: {output} Challenge: {100 * n + v}")
        if output == goal:
            break
    if output == goal:
        break
