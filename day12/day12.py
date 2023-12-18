#!/usr/bin/env python3
import sys

dejavu = {}
def solve(pfx, nums):
    if pfx == "":
        return 1 if nums == () else 0
    if nums == ():
        return 0 if "#" in pfx else 1

    if (pfx, nums) in dejavu:
        return dejavu[(pfx, nums)]

    result = 0

    if pfx[0] in ".?":
        result += solve(pfx[1:], nums)

    if pfx[0] in "#?":
        if nums[0] <= len(pfx) and "." not in pfx[:nums[0]] and (nums[0] == len(pfx) or pfx[nums[0]] != "#"):
            result += solve(pfx[nums[0] + 1:], nums[1:])

    dejavu[(pfx, nums)] = result
    return result

def solve12(line, part):
    pfx, nums = line.split()
    nums = tuple(map(int, nums.split(",")))
    if part==2:
        pfx = "?".join([pfx] * 5)
        nums *= 5
    return solve(pfx, nums)

lines=sys.stdin.read()
for part in [1, 2]:
    totalsolutions = 0
    for line in lines.splitlines():
        totalsolutions += solve12(line, part)

    print(str(part)+':', totalsolutions)