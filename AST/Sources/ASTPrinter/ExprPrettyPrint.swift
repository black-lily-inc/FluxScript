import AST

internal struct ExprPrettyPrint: ExprVisitor {
    public typealias ExprVisitorReturnType = String

    private let indent: String

    public init(indent: String) {
        self.indent = indent
    }

    public func build(expr: Expr) throws -> String {
        return try expr.accept(visitor: self)
    }

    public func visitBinaryExpr(_ expr: Binary) throws -> String {
        var result = "binary (\(expr.op.literal))\n"
        let leftStr = try expr.left.accept(visitor: Self(indent: indent + "│   "))
        let rightStr = try expr.right.accept(visitor: Self(indent: indent + "    "))
        result += indent + "├── " + leftStr + "\n"
        result += indent + "└── " + rightStr
        return result
    }

    public func visitGroupingExpr(_ expr: Grouping) throws -> String {
        let inner = try expr.expression.accept(visitor: Self(indent: indent + "    "))
        return "group\n" + indent + "└── " + inner
    }

    public func visitLiteralExpr(_ expr: Literal) throws -> String {
        return expr.value.map { "literal \($0)" } ?? "nil"
    }

    public func visitUnaryExpr(_ expr: Unary) throws -> String {
        let right = try expr.right.accept(visitor: Self(indent: indent + "    "))
        return "unary (\(expr.op.literal))\n" + indent + "└── " + right
    }

    public func accept(expr: Expr) throws -> String {
        return try expr.accept(visitor: self)
    }
}
