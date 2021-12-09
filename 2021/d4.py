from pandas import *
with open('d4_input.txt', 'r', encoding='utf-16') as f:
    lines = [j for j in f.readlines() if j != '\n']

calling_numbers = [int(n) for n in lines[0].split(",")]
boards, board = ([],[])

for line in lines[1:]:
    line_split = line.replace('\n','').split(" ")
    numbers = [int(n) for n in line_split if n != ""]
    board.append(numbers)
    
    if len(board) > 4:
        boards.append(board)
        board = []

def check_for_win(board):
    # horiz_win, vert_win, diag_win = (False, False, False)
    b_diag_win, f_diag_win = (True, True)
    for i in range(5):
        row_win, col_win = (True, True)
        for j in range(5):

            #horiz
            if board[i][j] < 100:
                row_win = False
    
            #vert
            if board[j][i] < 100:
                col_win = False
        if row_win or col_win:
            return True

        #diag
    #     if board[i][i] < 100:
    #         b_diag_win = False
    #     if board[4-i][i] < 100:
    #         f_diag_win = False

    # if b_diag_win or f_diag_win:
    #     return True
    return False
winning_boards = []
last_winner = False
for number in calling_numbers:
    for key, board in enumerate(boards):
        if key in winning_boards: 
            continue
        for row in range(5):
            for col in range(5):
                if board[row][col] == number:
                    board[row][col] += 100
        
        print(f"Board: {key}")
        print("")
        
        if check_for_win(board):
            winning_boards.append(key)
        if len(winning_boards) == len(boards):
            print("Last Winner Found")
            print(DataFrame(board))
            score = 0
            for row in range(5):
                score += sum([x for x in board[row] if x < 100])
            print(f"Score: {score}")
            print(f"Number called: {number}")
            print(f"Final Score: {score * number}")
            last_winner = True
            break
    if last_winner:
        break


    #p1
    #     if winner:
    #         print("Winner")
    #         score = 0
    #         for row in range(5):
    #             score += sum([x for x in board[row] if x < 100])
    #         print(f"Score: {score}")
    #         print(f"Number called: {number}")
    #         print(f"Final Score: {score * number}")
    #         break
    # if winner:
    #     break