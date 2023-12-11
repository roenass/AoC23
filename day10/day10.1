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

while q:
    r, c = q.popleft()
    ch = grid[r][c]

    if r > 0 and ch in "S|JL" and grid[r - 1][c] in "|7F" and (r - 1, c) not in loop:
        loop.add((r - 1, c))
        q.append((r - 1, c))
        
    if r < len(grid) - 1 and ch in "S|7F" and grid[r + 1][c] in "|JL" and (r + 1, c) not in loop:
        loop.add((r + 1, c))
        q.append((r + 1, c))

    if c > 0 and ch in "S-J7" and grid[r][c - 1] in "-LF" and (r, c - 1) not in loop:
        loop.add((r, c - 1))
        q.append((r, c - 1))

    if c < len(grid[r]) - 1 and ch in "S-LF" and grid[r][c + 1] in "-J7" and (r, c + 1) not in loop:
        loop.add((r, c + 1))
        q.append((r, c + 1))

print(len(loop) // 2)