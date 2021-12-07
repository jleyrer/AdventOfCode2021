import Foundation
import PlaygroundSupport
import Algorithms

// MARK: - Part 1

let measurements = getInput(fileName: "Day1-input").map { Int($0)! }
var count = 0

for (index, value) in measurements.enumerated() {
    guard index > 0 else {
        continue
    }

    if value > measurements[index - 1] {
        count += 1
    }
}

print("*** Part 1 ***")
print("\(count) measurements are larger than the previous measurement.\n")

// MARK: - Part 2

let pt2Solution = measurements.windows(ofCount: 3).adjacentPairs().map({ $0.0.reduce(0, +) < $0.1.reduce(0, +) ? 1 : 0 }).reduce(0, +)

print("*** Part 2 ***")
print("\(pt2Solution) sums are larger than the previous sum.")
