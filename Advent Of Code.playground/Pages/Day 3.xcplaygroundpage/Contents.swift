import Foundation
import PlaygroundSupport

let diagnostics = getInput(fileName: "Day3-input")
var mostCommonValues: [String] = []
var leastCommonValues: [String] = []

func binaryToInt(binaryString: String) -> UInt {
    return strtoul(binaryString, nil, 2)
}

// MARK: - Part 1

(0..<diagnostics.first!.count).forEach { index in
    var zeroCount = 0
    var oneCount = 0

    diagnostics.forEach { diagnostic in
        switch diagnostic[diagnostic.index(diagnostic.startIndex, offsetBy: index)] {
        case "0":
            zeroCount += 1
        case "1":
            oneCount += 1
        default:
            break
        }
    }

    mostCommonValues.append(zeroCount > oneCount ? "0" : "1")
    leastCommonValues.append(zeroCount < oneCount ? "0" : "1")
}

let gammaRateString = mostCommonValues.joined()
let epsilonRateString = leastCommonValues.joined()

print("*** Part 1 ***")
print("Power consumption rate: \(binaryToInt(binaryString: gammaRateString) * binaryToInt(binaryString: epsilonRateString))")

// MARK: - Part 2

var oxygenGeneratorRating: [String] = diagnostics

for index in (0..<diagnostics.first!.count) {
    var zeroCount = 0
    var oneCount = 0

    oxygenGeneratorRating.forEach { diagnostic in
        switch diagnostic[diagnostic.index(diagnostic.startIndex, offsetBy: index)] {
        case "0":
            zeroCount += 1
        case "1":
            oneCount += 1
        default:
            break
        }
    }

    if zeroCount > oneCount {
        oxygenGeneratorRating.removeAll(where: { $0[$0.index($0.startIndex, offsetBy: index)] == "1" })
    } else {
        oxygenGeneratorRating.removeAll(where: { $0[$0.index($0.startIndex, offsetBy: index)] == "0" })
    }

    if oxygenGeneratorRating.count == 1 {
        break
    }
}

print(oxygenGeneratorRating.first!)

var c02ScrubberRating: [String] = diagnostics

for index in (0..<diagnostics.first!.count) {
    var zeroCount = 0
    var oneCount = 0

    c02ScrubberRating.forEach { diagnostic in
        switch diagnostic[diagnostic.index(diagnostic.startIndex, offsetBy: index)] {
        case "0":
            zeroCount += 1
        case "1":
            oneCount += 1
        default:
            break
        }
    }

    if oneCount < zeroCount {
        c02ScrubberRating.removeAll(where: { $0[$0.index($0.startIndex, offsetBy: index)] == "0" })
    } else {
        c02ScrubberRating.removeAll(where: { $0[$0.index($0.startIndex, offsetBy: index)] == "1" })
    }

    if c02ScrubberRating.count == 1 {
        break
    }
}

print("*** Part 2 ***")
print("Life support rating: \(binaryToInt(binaryString: oxygenGeneratorRating.first!) * binaryToInt(binaryString: c02ScrubberRating.first!))")

