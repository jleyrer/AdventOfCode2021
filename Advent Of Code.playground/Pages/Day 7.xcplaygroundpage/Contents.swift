import Foundation

let positions = getInput(fileName: "Day7-input").first!.split(separator: ",").map({ Int($0)! }).sorted(by: <)
let median = positions[positions.count / 2]
let totalDistance = positions.map({ abs($0 - median) }).reduce(0, +)

print("*** Part 1 ***")
print("The crabs must expend \(totalDistance) total fuel to align at position \(median).\n")

func addDistances(_ n: Int) -> Int {
    guard n != 0 else {
        return 0
    }

    return (1...n).reduce(0, +)
}

let mean = positions.reduce(1, +) / positions.count
let totalDistance2 = positions.map({ abs($0 - mean) }).map({ addDistances($0) }).reduce(0, +)

print("*** Part 2 ***")
print("The crabs must expend \(totalDistance2) total fuel to align at position \(mean).")
