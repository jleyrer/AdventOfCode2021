import Algorithms
import Foundation
import PlaygroundSupport

struct Square {
    let value: Int
    var isDrawn: Bool
}

struct Board {
    var rows: [[Square]]

    var columns: [[Square]] {
        var columns: [[Square]] = []

        (0..<5).forEach { index in
            let column = rows.map { $0[index] }
            columns.append(column)
        }

        return columns
    }

    var isWinner: Bool = false

    var score: Int {
        var score = 0

        rows.forEach { row in
            score += row.filter({ !$0.isDrawn }).reduce(0) { count, square in
                count + square.value
            }
        }

        return score
    }

    mutating func markNumber(_ value: Int) {
        for (rowIndex, row) in rows.enumerated() {
            if let matchIndex = row.firstIndex(where: { $0.value == value }) {
                rows[rowIndex][matchIndex].isDrawn = true
                break
            }
        }

        updateStatus()
    }

    mutating func updateStatus() {
        guard !isWinner else { return }

        for row in rows {
            if row.reduce(0, { $0 + ($1.isDrawn ? 1 : 0) }) == 5 {
                isWinner = true
                return
            }
        }

        for column in columns {
            if column.reduce(0, { $0 + ($1.isDrawn ? 1 : 0) }) == 5 {
                isWinner = true
                return
            }
        }
    }
}

var input = getInput(fileName: "Day4-input")
let drawnNumbers = input.removeFirst().split(separator: ",").map { Int($0)! }

func populateBoards() -> [Board] {
    let chunks = input.filter({ !$0.isEmpty }).chunks(ofCount: 5)

    return chunks.map { chunk in
        Board(rows: chunk.map {
            $0.split(separator: " ").map {
                Square(value: Int($0)!, isDrawn: false)
            }
        })
    }
}

// MARK: - Part 1

var boards = populateBoards()

for number in drawnNumbers {
    for (index, _) in boards.enumerated() { boards[index].markNumber(number) }

    guard let winningBoard = boards.filter({ $0.isWinner }).first else {
        continue
    }

    print("*** Part 1 ***")
    print("Winning number: \(number)")
    print("Board total: \(winningBoard.score)")
    print("Winning score: \(winningBoard.score * number)\n")

    break
}

// MARK: - Part 2

boards = populateBoards()

for number in drawnNumbers {
    for (index, board) in boards.enumerated() {
        guard !board.isWinner else { continue }
        
        boards[index].markNumber(number)

        if boards.filter({ !$0.isWinner }).isEmpty {
            print("*** Part 2 ***")
            print("Final number: \(number)")
            print("Board total: \(boards[index].score)")
            print("Winning score: \(boards[index].score * number)")

            break
        }
    }
}
