import Foundation
import Tokenizer
import AST

public struct FluxScript {
    public init() {}
    
    public func run(input: String) throws {
        let tokens = try Tokenizer(source: input).scanTokens()
        let ast = try AST
    }
}
