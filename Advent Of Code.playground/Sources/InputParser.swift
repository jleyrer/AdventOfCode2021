import Foundation

public func getInput(fileName: String) -> [String] {
    let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt")
    let text = try! String(contentsOf: fileUrl!, encoding: .utf8)

    return text.split(separator: "\n").map { String($0) }
}
