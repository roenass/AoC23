#! /usr/bin/env python3

import sys
import re
from math import gcd
from collections import Counter


def lcm(ls):
  lcm = 1
  for x in ls:
    lcm = (x*lcm)//gcd(x,lcm)
  return lcm

def FindPath(SecondPart, Steps, Directions):
  Position = []
  for s in Directions['L']:
    if s.endswith('A' if SecondPart else 'AAA'):
      Position.append(s)
  T = {}
  total = 0
  while True:
    NewPosition = []
    for i,p in enumerate(Position):
      p = Directions[Steps[total%len(Steps)]][p]
      if p.endswith('Z'):
        T[i] = total+1
        # we need to solve total % A[i] == 0 for 6 different values of A[i]
        # in general, you could have to solve total % A[i] = B[i].
        # you can do this with the chinese remainder theorem
        # which provides the lowest common multiplier
        if len(T) == len(Position):
          return lcm(T.values())
      NewPosition.append(p)
    Position = NewPosition
    total += 1

def ReadInput(Rdr):
  moves = {'L': {}, 'R': {}}
  steps, directions = Rdr.split('\n\n')
  for line in directions.translate(str.maketrans('','', '()')).split('\n'):
    st, lr = line.split(' = ')
    l, r = lr.split(', ')
    moves['L'][st] = l
    moves['R'][st] = r
  return steps, moves

InRdr = sys.stdin.read().strip()
Steps, Moves = ReadInput(InRdr)
for FirstPart in [False, True]:
 print(FindPath(FirstPart, Steps, Moves))
