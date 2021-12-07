import PlaygroundSupport
import UIKit

let movements = getInput(fileName: "Day2-input").map { line -> (direction: Substring, value: Int) in
    let components = line.split(separator: " ")

    return (components[0], Int(components[1])!)
}

// MARK: - Part 1

var horizontalPosition: Int = 0
var depth: Int = 0

movements.forEach { movement in
    switch movement.direction {
    case "forward":
        horizontalPosition += movement.value
    case "up":
        depth -= movement.value
    case "down":
        depth += movement.value
    default:
        break
    }
}

print("*** Part 1 ***")
print("Horizontal position: \(horizontalPosition)")
print("Depth: \(depth)")
print("Final answer: \(horizontalPosition * depth)\n")

// MARK: - Part 2

var aim: Int = 0
horizontalPosition = 0
depth = 0

movements.forEach { movement in
    switch movement.direction {
    case "forward":
        horizontalPosition += movement.value
        depth += aim * movement.value
    case "up":
        aim -= movement.value
    case "down":
        aim += movement.value
    default:
        break
    }
}

print("*** Part 2 ***")
print("Horizontal position: \(horizontalPosition)")
print("Depth: \(depth)")
print("Final answer: \(horizontalPosition * depth)")
