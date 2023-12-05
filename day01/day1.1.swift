#!/usr/bin/env swift -enable-bare-slash-regex

let simpleDigits = /([0-9])/

var inputS: [String] = []
var sum = 0

while let input = readLine() {
    inputS.append(input)
}

for l in inputS {
    var num = 0
    if let match = l.firstMatch(of: simpleDigits) {
        num = Int(match.1) ?? 0
        sum = sum + num * 10
    }
    if let match = String(l.reversed()).firstMatch(of: simpleDigits) {
        num = Int(match.1) ?? 0
        sum = sum + num
    }
}
print("Total: \(sum).")
