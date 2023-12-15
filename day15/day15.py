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
    box = hash(label)
    boxes[box] = [(lbl,fcs) for (lbl,fcs) in boxes[box] if lbl!=label]
  elif step[-2]=='=':
    label = step[:-2]
    box = hash(label)
    lastslot = int(step[-1])
    if label in [lbl for (lbl,fcs) in boxes[box]]:
      boxes[box] = [(lbl, lastslot if lbl==label else fcs) for (lbl,fcs) in boxes[box]]
    else:
      boxes[box].append((label, lastslot))

p2 = 0
for i,boxes in enumerate(boxes):
  for j,(lbl,fcs) in enumerate(boxes):
    p2 += (i+1)*(j+1)*fcs
print(p2)
