import Foundation

let initialFish = getInput(fileName: "Day6-input").first!.split(separator: ",").map { Int($0)! }

struct Ocean {
    private(set) var fish: [Int]

    var totalFish: Int {
        fish.reduce(0, +)
    }

    init(initialfFish: [Int]) {
        fish = initialfFish.reduce(into: Array(repeating: 0, count: 9)) { $0[$1] += 1 }
    }

    mutating func populateFish(days: Int) {
        (0..<days).forEach { _ in
            fish = fish[1..<7] + [fish[7] + fish[0], fish[8], fish[0]]
        }
    }
}

var ocean = Ocean(initialfFish: initialFish)
ocean.populateFish(days: 80)
print("*** Part 1 ***")
print("There are \(ocean.totalFish) lanternfish after 80 days.")

ocean = Ocean(initialfFish: initialFish)
ocean.populateFish(days: 256)
print("*** Part 2 ***")
print("There are \(ocean.totalFish) lanternfish after 256 days.")
