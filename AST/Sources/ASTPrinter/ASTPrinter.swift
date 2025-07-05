import AST
import Tokenizer

@main
struct ASTPrinter {
    static func main() throws {
        // TODO: Allow inputting a FluxScript Script to see this representation
        let expression = Binary(
            left: Unary(
                op: Token(literal: "-", type: .subtraction),
                right: Literal(value: 123)
            ),
            op: Token(literal: "*", type: .multiplication),
            right: Grouping(
                expression: Binary(
                    left: Literal(value: 123),
                    op: Token(literal: "-", type: .subtraction),
                    right: Literal(value: 199)
                )
            )
        )
        let printValue = try ExprPrettyPrint(indent: "\t").build(expr: expression)
        print("[PP] - FluxScript Visitor Pretty Printer\n\t\(printValue)")
    }
}
