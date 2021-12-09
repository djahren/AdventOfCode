minimum = 236491
# minimum = 111122
maximum = 713787
num_found = 0
for n in range(minimum, maximum + 1):
    two_adjacent = False
    increasing = True
    not_larger_group = False
    adjacent_counts = {}

    num_string = str(n)
    for i in range(len(num_string) - 1):
        current_char = num_string[i:i+1]
        next_char = num_string[i+1:i+2]

        # Going from left to right, the digits never decrease; they only ever increase
        # or stay the same (like 111123 or 135679)
        if current_char > next_char:
            increasing = False
            break
        # Two adjacent digits are the same (like 22 in 122345).
        if current_char == next_char:
            two_adjacent = True
            adjacent_chars = current_char + next_char

            # the two adjacent matching digits are not part of a larger group of matching digits
            adjacent_counts[adjacent_chars] = 0
            for j in range(len(num_string) - 1):
                if adjacent_chars == num_string[j:j+2]:
                    adjacent_counts[adjacent_chars] += 1

    # print(adjacent_counts)
    for key in adjacent_counts:
        # print(adjacent_counts[key])
        if adjacent_counts[key] == 1:
            not_larger_group = True

    if two_adjacent and increasing and not_larger_group:
        num_found += 1
        print(num_string)

print(num_found)

