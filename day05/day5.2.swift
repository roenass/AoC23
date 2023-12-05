#!/usr/bin/env swift -enable-bare-slash-regex
//import Foundation

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

var seed2locationmap            : [Int: Int]   = [:]
var soil2locationmap            : [Int: Int]   = [:]
var fertilizer2locationmap      : [Int: Int]   = [:]
var water2locationmap           : [Int: Int]   = [:]
var light2locationmap           : [Int: Int]   = [:]
var temperature2locationmap     : [Int: Int]   = [:]
var humidity2locationmap2       : [Int: Int]   = [:]

func fillMap(dst: Int, src: Int, len: Int, map: [Int: [Int]]) -> [Int: [Int]] {
    var newmap = map
    newmap[src] = [dst, len]
    return newmap
}

func lookupMap(src: Int, map: [Int: [Int]]) -> Int {
    for (k,v) in Array(map).sorted(by: {$0.0 < $1.0}) {
        if src >= k && src < k+v[1] {
            let offset = src - k
            if offset < k+v[1] {
                return offset+v[0]
            }
        }
    }
    return src
}

func seedtolocation(seed: Int) -> Int {
    var id : Int
    
    id = seed2locationmap[seed] ?? -1
    if id != -1 {
        return id
    }
    let soil = lookupMap(src: seed, map: seed2soilmap)

    // soil 2 location or fertilizer
    id = soil2locationmap[soil] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        return id
    }
    let fert = lookupMap(src: soil, map: soil2fertilizermap)

    // fertilizer 2 location or water
    id = fertilizer2locationmap[fert] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        soil2locationmap[soil] = id
        return id
    }
    let watr = lookupMap(src: fert, map: fertilizer2watermap)

    // water 2 location or light
    id = water2locationmap[watr] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        soil2locationmap[soil] = id
        fertilizer2locationmap[fert] = id
        return id
    }
    let lite = lookupMap(src: watr, map: water2lightmap)

    // light 2 location or temperature
    id = light2locationmap[lite] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        soil2locationmap[soil] = id
        fertilizer2locationmap[fert] = id
        water2locationmap[watr] = id
        return id
    }
    let temp = lookupMap(src: lite, map: light2temperaturemap)
    light2locationmap[id] = temp

    // temperature 2 location or humidity
    id = temperature2locationmap[temp] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        soil2locationmap[soil] = id
        fertilizer2locationmap[fert] = id
        water2locationmap[watr] = id
        light2locationmap[lite] = id
        return id
    }
    let humd = lookupMap(src: temp, map: temperature2humiditymap)
    temperature2locationmap[temp] = humd

    // humidity 2 location or location
    id = humidity2locationmap2[humd] ?? -1
    if id != -1 {
        seed2locationmap[seed] = id
        soil2locationmap[soil] = id
        fertilizer2locationmap[fert] = id
        water2locationmap[watr] = id
        light2locationmap[lite] = id
        temperature2locationmap[temp] = id
        return id
    }
    id = lookupMap(src: humd, map: humidity2locationmap)
    seed2locationmap[seed] = id
    soil2locationmap[soil] = id
    fertilizer2locationmap[fert] = id
    water2locationmap[watr] = id
    light2locationmap[lite] = id
    temperature2locationmap[temp] = id
    humidity2locationmap2[humd] = id

/* 
    print("  soil \(soil)")
    print("    fert \(fert)")
    print("      watr \(watr)")
    print("        lite \(lite)")
    print("          temp \(temp)")
    print("            humd \(humd)")
    print("              locn \(id)")
 */

    return id
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
for (k,v) in Array(seed2soilmap).sorted(by: {$0.0 < $1.0}) {
    print("seed2soilmap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(soil2fertilizermap).sorted(by: {$0.0 < $1.0}) {
    print("soil2fertilizermap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(fertilizer2watermap).sorted(by: {$0.0 < $1.0}) {
    print("fertilizer2watermap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(water2lightmap).sorted(by: {$0.0 < $1.0}) {
    print("water2lightmap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(light2temperaturemap).sorted(by: {$0.0 < $1.0}) {
    print("light2temperaturemap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(temperature2humiditymap).sorted(by: {$0.0 < $1.0}) {
    print("temperature2humiditymap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
for (k,v) in Array(humidity2locationmap).sorted(by: {$0.0 < $1.0}) {
    print("humidity2locationmap \(k)..\(k+v[1]-1) ==> \(v[0])...\(v[0] + v[1]-1) : \(v)")
}
 */


var firstSeed = true
var seed = 0
var seedcount = 0

// seeds = "82 2"
for sd in seeds.split(separator: " ") {
    if let i = Int(sd) {
        if (firstSeed) {
            firstSeed = false
            seed = i
        } else {
            firstSeed = true
            seedcount = i
            for s in seed...seed+seedcount-1 {
                var loc : Int = minLoc
                if s == seed || s % 100000 == 0 {
                    print("Seed \(s)/\(seed + seedcount), \(seed+seedcount - s) remaining")
                }
                loc = seedtolocation(seed: s)
//                print(">seed \(s) loc \(loc)")
                if loc < minLoc {  minLoc = loc }
            }
        }
    }
}

print("Minimal location: \(minLoc)")
