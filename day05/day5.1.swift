#!/usr/bin/env swift -enable-bare-slash-regex
import Foundation

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

var inputS: [String] = []
var seeds: String = ""
var currentMap = 0
var minLoc = 999999999999

var seed2soilmap                : [Int: [Int]] = [:]
var soil2fertilizermap          : [Int: [Int]] = [:]
var fertilizer2watermap         : [Int: [Int]] = [:]
var water2lightmap              : [Int: [Int]] = [:]
var light2temperaturemap        : [Int: [Int]] = [:]
var temperature2humiditymap     : [Int: [Int]] = [:]
var humidity2locationmap        : [Int: [Int]] = [:]


func fillMap(dst: Int, src: Int, len: Int, map: [Int: [Int]]) -> [Int: [Int]] {
    var newmap = map
    //for i in 0...len-1 { newmap[src+i] = dst+i }
    newmap[src] = [dst, len]
    return newmap
}

func lookupMap(src: Int, map: [Int: [Int]]) -> Int {
    for (k,v) in Array(map).sorted(by: {$0.0 < $1.0}) {
        if src > k && src >= k+v[1] {
        }
        if src > k && src < k+v[1] {
            let offset = src - k
            if offset < k+v[1] {
                return offset+v[0]
            }
        }
    }
    return src
}

// ---- Main ----

while let input = readLine() {
    inputS.append(input)
}

for l in inputS {
    if l.hasPrefix("seeds: ") { // true
        seeds = l.deletingPrefix("seeds: ")
    }
    if l.hasPrefix("seed-to-soil map:")             { currentMap = 1 }
    if l.hasPrefix("soil-to-fertilizer map:")       { currentMap = 2 }
    if l.hasPrefix("fertilizer-to-water map:")      { currentMap = 3 }
    if l.hasPrefix("water-to-light map:")           { currentMap = 4 }
    if l.hasPrefix("light-to-temperature map:")     { currentMap = 5 }
    if l.hasPrefix("temperature-to-humidity map:")  { currentMap = 6 }
    if l.hasPrefix("humidity-to-location map:")     { currentMap = 7 }

    if l.firstMatch(of: /^[0-9]/) != nil {
        let numS = l.split(separator: " ")
        let dstStart =  Int(numS[0]) ?? 0
        let srcStart =  Int(numS[1]) ?? 0
        let rngLength = Int(numS[2]) ?? 0
        switch currentMap {
        case 1:
            seed2soilmap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: seed2soilmap)
        case 2:
            soil2fertilizermap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: soil2fertilizermap)
        case 3:
            fertilizer2watermap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: fertilizer2watermap)
        case 4:
            water2lightmap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: water2lightmap)
        case 5:
            light2temperaturemap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: light2temperaturemap)
        case 6:
            temperature2humiditymap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: temperature2humiditymap)
        case 7:
            humidity2locationmap = fillMap(dst: dstStart, src: srcStart, len: rngLength, map: humidity2locationmap)
        default:
            print("anomaly")
        }
    }
}

/*
    The gardener and his team want to get started as soon as possible, so
    they'd like to know the closest location that needs a seed. Using these
    maps, find the lowest location number that corresponds to any of the
    initial seeds. To do this, you'll need to convert each seed number through
    other categories until you can find its corresponding location number.
 */


for s in seeds.split(separator: " ") {
    if let i = Int(s) {
        let soil = lookupMap(src: i, map: seed2soilmap)
        let fert = lookupMap(src: soil, map: soil2fertilizermap)
        let watr = lookupMap(src: fert, map: fertilizer2watermap)
        let lite = lookupMap(src: watr, map: water2lightmap)
        let temp = lookupMap(src: lite, map: light2temperaturemap)
        let humd = lookupMap(src: temp, map: temperature2humiditymap)
        let locn = lookupMap(src: humd, map: humidity2locationmap)
        if locn < minLoc {
            minLoc = locn
        }
    }
}

print("Minimal location: \(minLoc)")
