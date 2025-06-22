import Foundation
import Tokenizer

public protocol Expr {
}

public extension Expr {
    func accept<V: ExprVisitor, R>(visitor: V) throws -> R where R == V.ExprVisitorReturnType {
        fatalError()
    }
}
public protocol ExprVisitor {
    associatedtype ExprVisitorReturnType
    
    func visitBinaryExpr(_ expr: Binary) -> ExprVisitorReturnType
    func visitGroupingExpr(_ expr: Grouping) -> ExprVisitorReturnType
    func visitLiteralExpr(_ expr: Literal) -> ExprVisitorReturnType
    func visitUnaryExpr(_ expr: Unary) -> ExprVisitorReturnType
}

public struct Binary: Expr {
    public let left: Expr
    public let op: Token
    public let right: Expr

    public init(left: Expr, op: Token, right: Expr) {
        self.left = left
        self.op = op
        self.right = right
    }

    public func accept<V: ExprVisitor, R>(visitor: V) throws -> R where R == V.ExprVisitorReturnType {
        return visitor.visitBinaryExpr(self)
    }
}

public struct Grouping: Expr {
    public let expression: Expr

    public init(expression: Expr) {
        self.expression = expression
    }

    public func accept<V: ExprVisitor, R>(visitor: V) throws -> R where R == V.ExprVisitorReturnType {
        return visitor.visitGroupingExpr(self)
    }
}

public struct Literal: Expr {
    public let value: Any

    public init(value: Any) {
        self.value = value
    }

    public func accept<V: ExprVisitor, R>(visitor: V) throws -> R where R == V.ExprVisitorReturnType {
        return visitor.visitLiteralExpr(self)
    }
}

public struct Unary: Expr {
    public let op: Token
    public let right: Expr

    public init(op: Token, right: Expr) {
        self.op = op
        self.right = right
    }

    public func accept<V: ExprVisitor, R>(visitor: V) throws -> R where R == V.ExprVisitorReturnType {
        return visitor.visitUnaryExpr(self)
    }
}

