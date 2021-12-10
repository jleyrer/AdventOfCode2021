import Foundation

let input = getInput(fileName: "Day10-input")

enum Token: String, CaseIterable {
    case parentheses = "()"
    case squareBrackets = "[]"
    case curlyBrackets = "{}"
    case angleBrackets = "<>"

    var opener: String {
        String(rawValue.first!)
    }

    var closer: String {
        String(rawValue.last!)
    }

    var syntaxErrorScore: Int {
        switch self {
        case .parentheses:
            return 3
        case .squareBrackets:
            return 57
        case .curlyBrackets:
            return 1197
        case .angleBrackets:
            return 25137
        }
    }

    var completionScore: Int {
        switch self {
        case .parentheses:
            return 1
        case .squareBrackets:
            return 2
        case .curlyBrackets:
            return 3
        case .angleBrackets:
            return 4
        }
    }

    static func token(for symbol: String) -> Token {
        switch symbol {
        case Token.parentheses.opener, Token.parentheses.closer:
            return .parentheses
        case Token.squareBrackets.opener, Token.squareBrackets.closer:
            return .squareBrackets
        case Token.curlyBrackets.opener, Token.curlyBrackets.closer:
            return .curlyBrackets
        default:
            return .angleBrackets
        }
    }
}

func stripTokens(from line: String) -> String {
    var stripped = line

    Token.allCases.forEach { stripped = stripped.replacingOccurrences(of: $0.rawValue, with: "") }

    return stripped != line ? stripTokens(from: stripped) : stripped
}

let strippedLines = input.map { stripTokens(from: $0) }
let matchPattern = "[\(Token.allCases.map({ "\\\($0.rawValue.last!)" }).joined())]"
var corruptedLines: [String: Int] = [:]

strippedLines.forEach { line in
    if let range = line.range(of: matchPattern, options: .regularExpression) {
        corruptedLines[line] = Token.token(for: String(line[range])).syntaxErrorScore
    }
}

print("*** Part 1 ***")
print("The total syntax error score is \(corruptedLines.reduce(0) { $0 + $1.value }).")

let incompleteLines = strippedLines.filter { corruptedLines[$0] == nil }
var incompleteLineScores: [String: Int] = [:]

incompleteLines.forEach { line in
    incompleteLineScores[line] = 0

    line.reversed().forEach { symbol in
        incompleteLineScores[line] = incompleteLineScores[line]! * 5
        incompleteLineScores[line]! += Token.token(for: String(symbol)).completionScore
    }
}

print("*** Part 2 ***")
print("The middle score is \(incompleteLineScores.values.sorted().map({ $0 })[incompleteLineScores.count / 2])")
