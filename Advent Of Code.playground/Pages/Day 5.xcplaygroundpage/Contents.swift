import Foundation
import PlaygroundSupport

struct VentPoint: Hashable {
    let x: Int
    let y: Int
}

struct LineSegment {
    let startingPoint: VentPoint
    let endingPoint: VentPoint

    var isDiagonal: Bool {
        !(dX == 0 || dY == 0)
    }

    var includedPoints: [VentPoint] {
        var points: [VentPoint] = []

        guard !isDiagonal else {
            for index in (0...abs(dX)) {
                points.append(
                    VentPoint(
                        x: startingPoint.x + (dX > 0 ? index : -index),
                        y: startingPoint.y + (dY > 0 ? index : -index)
                    )
                )
            }

            return points
        }

        if startingPoint.x == endingPoint.x {
            let startY = min(startingPoint.y, endingPoint.y)
            let endY = max(startingPoint.y, endingPoint.y)

            (startY...endY).forEach { y in
                points.append(VentPoint(x: startingPoint.x, y: y))
            }

            return points

        } else if startingPoint.y == endingPoint.y {
            let startX = min(startingPoint.x, endingPoint.x)
            let endX = max(startingPoint.x, endingPoint.x)

            (startX...endX).forEach { x in
                points.append(VentPoint(x: x, y: startingPoint.y))
            }

            return points
        }

        return []
    }

    private var dX: Int {
        endingPoint.x - startingPoint.x
    }

    private var dY: Int {
        endingPoint.y - startingPoint.y
    }
}

enum LineSegmentTypes {
    case nonDiagonal
    case all
}

func generateLineSegments(type: LineSegmentTypes) -> [LineSegment] {
    input.compactMap { line in
        let pairs = line.components(separatedBy: " -> ")

        let firstPair = pairs[0].split(separator: ",")
        let secondPair = pairs[1].split(separator: ",")

        let dX = Int(firstPair[0])! - Int(secondPair[0])!
        let dY = Int(firstPair[1])! - Int(secondPair[1])!

        let condition: Bool =
            type == .nonDiagonal
            ? (dX == 0 || dY == 0)
            : dX == 0 || dY == 0 || abs(dX) == abs(dY)

        guard condition else { return nil }

        return LineSegment(
            startingPoint: VentPoint(x: Int(firstPair[0])!, y: Int(firstPair[1])!),
            endingPoint: VentPoint(x: Int(secondPair[0])!, y: Int(secondPair[1])!)
        )
    }
}

let input = getInput(fileName: "Day5-input")
var part1Points: [VentPoint: Int] = [:]

generateLineSegments(type: .nonDiagonal).forEach { lineSegment in
    lineSegment.includedPoints.forEach { point in
        part1Points[point] = (part1Points[point] ?? 0) + 1
    }
}

print("*** Part 1 ***")
print(part1Points.filter({ $0.value > 1 }).count)
print("\n")

var part2Points: [VentPoint: Int] = [:]

generateLineSegments(type: .all).forEach { lineSegment in
    lineSegment.includedPoints.forEach { point in
        part2Points[point] = (part2Points[point] ?? 0) + 1
    }
}

print("*** Part 2 ***")
print(part2Points.filter({ $0.value > 1 }).count)
