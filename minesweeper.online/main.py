from json import loads
from random import choice

from flask_cors import CORS
from flask import Flask, jsonify, request

from minesweepr.minesweeper import solve, Rule, MineCount

app = Flask(__name__)
CORS(app)

MINES_COUNT = 130

@app.route("/solve", methods=["GET"])
def get_tasks():
    board = loads(request.args.get("board"))
    height, width = len(board), len(board[0])
    rules = []
    xs = []
    for y in range(height):
        for x in range(width):
            cell = board[y][x]
            if cell == "x":
                xs.append("%d_%d" % (x, y))
            elif cell == "X":
                return "solved"
            elif int(cell) != 0:
                neighbourhood = []
                for yy in range(max(y - 1, 0), min(y + 1, height - 1) + 1):
                    for xx in range(max(x - 1, 0), min(x + 1, width - 1) + 1):
                        if board[yy][xx] == "x":
                            neighbourhood.append("%d_%d" % (xx, yy))
                if len(neighbourhood) < int(cell):
                    print("=" * 100)
                    print(x, y, cell, neighbourhood)
                    print("=" * 100)
                rules.append(Rule(int(cell), neighbourhood))
    if len(xs) == MINES_COUNT:
        return "solved"
    # TODO: write wrapper for function
    solution = solve(rules, MineCount(total_cells=height*width, total_mines=MINES_COUNT))
    others = [xy for xy in xs if xy not in solution]
    min_probability = min(solution.values())
    to_click = [k for k, p in solution.items() if abs(p - min_probability) < 1e-6]
    return jsonify(solution)
    if len(to_click) > 1:
        optimum = to_click[0] if to_click[0] is not None else to_click[1]
    else:
        if len(others) == 0:
            second_min = min([p for p in solution.values() if p > min_probability])
            to_click = [k for k, p in solution.items() if abs(p - second_min) < 1e-6]
            # TODO: sample
            optimum = to_click[0]
        else:
            optimum = choice(others)
    return optimum


if __name__ == '__main__':
    app.run(debug=True)
