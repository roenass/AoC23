#! /usr/bin/env python3

import sys
from collections import deque

grid = sys.stdin.read().strip().splitlines()

for rownum, row in enumerate(grid):
    for colnum, char in enumerate(row):
        if char == "S":
            sr = rownum
            sc = colnum
            break
    else:
        continue
    break

loop = {(sr, sc)}
q = deque([(sr, sc)])

couldbees = {"|", "-", "J", "L", "7", "F"}

while q:
    r, c = q.popleft()
    ch = grid[r][c]

    if r > 0 and ch in "S|JL" and grid[r - 1][c] in "|7F" and (r - 1, c) not in loop:
        loop.add((r - 1, c))
        q.append((r - 1, c))
        if ch == "S":
            couldbees &= {"|", "J", "L"}
        
    if r < len(grid) - 1 and ch in "S|7F" and grid[r + 1][c] in "|JL" and (r + 1, c) not in loop:
        loop.add((r + 1, c))
        q.append((r + 1, c))
        if ch == "S":
            couldbees &= {"|", "7", "F"}

    if c > 0 and ch in "S-J7" and grid[r][c - 1] in "-LF" and (r, c - 1) not in loop:
        loop.add((r, c - 1))
        q.append((r, c - 1))
        if ch == "S":
            couldbees &= {"-", "J", "7"}

    if c < len(grid[r]) - 1 and ch in "S-LF" and grid[r][c + 1] in "-J7" and (r, c + 1) not in loop:
        loop.add((r, c + 1))
        q.append((r, c + 1))
        if ch == "S":
            couldbees &= {"-", "L", "F"}

assert len(couldbees) == 1
(S,) = couldbees

grid = [row.replace("S", S) for row in grid]
grid = ["".join(ch if (r, c) in loop else "." for c, ch in enumerate(row)) for r, row in enumerate(grid)]

outside = set()

for r, row in enumerate(grid):
    within = False
    up = None
    for c, ch in enumerate(row):
        if ch == "|":
            assert up is None
            within = not within
        elif ch == "-":
            assert up is not None
        elif ch in "LF":
            assert up is None
            up = ch == "L"
        elif ch in "7J":
            assert up is not None
            if ch != ("J" if up else "7"):
                within = not within
            up = None
        elif ch == ".":
            pass
        else:
            raise RuntimeError(f"unexpected character (horizontal): {ch}")
        if not within:
            outside.add((r, c))
            
print(len(grid) * len(grid[0]) - len(outside | loop))