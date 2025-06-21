import Foundation
import Tokenizer

public struct FluxScript {
    public init() {}
    
    public func run(input: String) throws {
        let tokens = try Tokenizer(source: input).scanTokens()
        print(tokens)
    }
}
