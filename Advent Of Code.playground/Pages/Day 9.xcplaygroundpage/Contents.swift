import Foundation

typealias LocationMap = [Location: Int]

struct Location: Hashable {
    let row: Int
    let column: Int

    var neighbors: [Location] {
        return [
            // up
            Location(row: row - 1, column: column),
            // down
            Location(row: row + 1, column: column),
            // left
            Location(row: row, column: column - 1),
            // right
            Location(row: row, column: column + 1),
        ]
    }
}

func parseHeights() -> LocationMap {
    let locations = getInput(fileName: "Day9-input").map { $0.map { Int(String($0))! } }
    var locationMap: LocationMap = [:]

    for row in 0..<locations.count {
        for column in 0..<locations[row].count {
            locationMap[Location(row: row, column: column)] = locations[row][column]
        }
    }

    return locationMap
}

func findLowPoints(in locationMap: LocationMap) -> LocationMap {
    locationMap.filter { location, height in
        location.neighbors.allSatisfy { (locationMap[$0] ?? Int.max) > height }
    }
}

func basin(from location: Location, locationMap: LocationMap) -> Set<Location> {
    fleshOutBasin(location: location, basinLocations: Set(), allLocations: locationMap)
}

func fleshOutBasin(location: Location, basinLocations: Set<Location>, allLocations: LocationMap) -> Set<Location> {
    let neighbors = location.neighbors
    var workingBasin = basinLocations
    workingBasin.insert(location)

    return neighbors.filter {
        !basinLocations.contains($0)
        && (allLocations[$0] ?? Int.min) > allLocations[location]!
        && allLocations[$0] != 9
    }.reduce(workingBasin) {
        fleshOutBasin(location: $1, basinLocations: $0, allLocations: allLocations)
    }
}

let locations = parseHeights()
let lowPoints = findLowPoints(in: locations)
let lowPointsSum = lowPoints.reduce(0) { $0 + $1.value + 1 }

print("*** Part 1 ***")
print("The sum of the risk levels for all low points is \(lowPointsSum)")

let basins = lowPoints.keys.map { basin(from: $0, locationMap: locations) }
let basinSizes = basins.map({ $0.count }).sorted(by: >).prefix(3)

print("*** Part 2 ***")
print("The product of the three largest basin sizes is \(basinSizes.reduce(1, *))")
