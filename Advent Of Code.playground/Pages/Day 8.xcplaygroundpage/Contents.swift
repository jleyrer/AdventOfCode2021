import Foundation

final class Reading {
    let signalPatterns: [String]
    let outputValues: [String]

    init(logEntry: String) {
        let components = logEntry
            .components(separatedBy: " | ")
            .map { $0.split(separator: " ").map(String.init) }

        signalPatterns = components[0]
        outputValues = components[1]
    }

    lazy var cfSignals: [String] = {
        signalPatterns.filter({ $0.count == 2 }).first!.map(String.init)
    }()

    lazy var aSignal: String = {
        signalPatterns.filter({ $0.count == 3 }).first!
            .replacingOccurrences(of: String(cfSignals.first!), with: "")
            .replacingOccurrences(of: String(cfSignals.last!), with: "")
    }()

    lazy var bdSignals: [String] = {
        signalPatterns.filter({ $0.count == 4 }).first!
            .replacingOccurrences(of: String(cfSignals.first!), with: "")
            .replacingOccurrences(of: String(cfSignals.last!), with: "")
            .map(String.init)
    }()

    lazy var egSignals: [String] = {
        signalPatterns.filter({ $0.count == 7 }).first!
            .replacingOccurrences(of: String(cfSignals.first!), with: "")
            .replacingOccurrences(of: String(cfSignals.last!), with: "")
            .replacingOccurrences(of: String(aSignal), with: "")
            .replacingOccurrences(of: String(bdSignals.first!), with: "")
            .replacingOccurrences(of: String(bdSignals.last!), with: "")
            .map(String.init)
    }()

    func calculateOutput() -> Int {
        let digits: [String] = outputValues.compactMap { value in
            switch value.count {
            case 2:
                return "1"
            case 3:
                return "7"
            case 4:
                return "4"
            case 5:
                if value.contains(signals: [aSignal, egSignals.first!, egSignals.last!]) &&
                    (
                        value.containsOneOf(first: cfSignals.first!, second: cfSignals.last!) ||
                        value.containsOneOf(first: bdSignals.first!, second: bdSignals.last!)
                    ) { return "2" }

                else if value.contains(signals: [aSignal, cfSignals.first!, cfSignals.last!]) &&
                    (
                        value.containsOneOf(first: egSignals.first!, second: egSignals.last!) ||
                        value.containsOneOf(first: bdSignals.first!, second: bdSignals.last!)
                    ) { return "3" }

                else { return "5" }
            case 6:
                if value.contains(signals: [aSignal, cfSignals.first!, cfSignals.last!, egSignals.first!, egSignals.last!]) &&
                    (value.containsOneOf(first: bdSignals.first!, second: bdSignals.last!))
                { return "0" }

                else if value.contains(signals: [aSignal, bdSignals.first!, bdSignals.last!, egSignals.first!, egSignals.last!]) &&
                    (value.containsOneOf(first: cfSignals.first!, second: cfSignals.last!))
                { return "6" }

                else { return "9" }
            case 7:
                return "8"
            default:
                return nil
            }
        }

        return Int(digits.joined())!
    }
}

extension String {
    func contains(signals: [String]) -> Bool {
        for signal in signals {
            if contains(signal) { continue }
            else { return false }
        }

        return true
    }

    func containsOneOf(first: String, second: String) -> Bool {
        (contains(first) && !contains(second)) || (contains(second) && !contains(first))
    }
}


let input = getInput(fileName: "Day8-input")
let readings: [Reading] = input.map { Reading(logEntry: $0) }

let outputDigitLengths = readings.map({ $0.outputValues }).map({ $0.map({ $0.count }) })
var outputDigitCounts: [Int: Int] = [:]

outputDigitLengths.forEach { output in
    outputDigitCounts = output.reduce(into: outputDigitCounts) { $0[$1] = ($0[$1] ?? 0) + 1 }
}

print("*** Part 1 ***")
print("The digits 1, 4, 7, and 8 appear \(outputDigitCounts[2]! + outputDigitCounts[4]! + outputDigitCounts[3]! + outputDigitCounts[7]!) times.\n")

let total = readings.map { $0.calculateOutput() }.reduce(0, +)
print("*** Part 2 ***")
print("The sum of all the output values is \(total)")
