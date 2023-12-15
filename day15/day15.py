#! /usr/bin/env python3

import sys
commands = sys.stdin.read().strip()

def hash(s):
  h = 0
  for c in s:
    h = ((h+ord(c))*17)%256
  return h

steps = commands.split(',')

p1sum = 0
for step in steps:
  p1sum += hash(step)
print(p1sum)

boxes = [[] for _ in range(256)]
for step in steps:
  if step[-1]=='-':
    label = step[:-1]
    b = hash(label)
    boxes[b] = [(l,f) for (l,f) in boxes[b] if l!=label]
  elif step[-2]=='=':
    label = step[:-2]
    b = hash(label)
    lastslot = int(step[-1])
    if label in [l for (l,f) in boxes[b]]:
      boxes[b] = [(l, lastslot if l==label else f) for (l,f) in boxes[b]]
    else:
      boxes[b].append((label, lastslot))

p2 = 0
for i,boxes in enumerate(boxes):
  for j,(l,f) in enumerate(boxes):
    p2 += (i+1)*(j+1)*f
print(p2)
