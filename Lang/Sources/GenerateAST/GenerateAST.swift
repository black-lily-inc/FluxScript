import Foundation

@main
struct GenerateAST {
    static func main() {
        let args = CommandLine.arguments

        if args.count != 2 {
            print("Usage: swift run GenerateAST <output_directory>")
            exit(64)
        }

        let outputDir = args[1]
        print("Output directory: \(outputDir)")

        do {
            try defineAst(outputDir: outputDir, baseName: "Expr", types: [
                "Binary   : left: Expr, op: Token, right: Expr",
                "Grouping : expression: Expr",
                "Literal  : value: Any?",
                "Unary    : op: Token, right: Expr"
            ])
        } catch {
            print("Error: \(error)")
            exit(1)
        }
    }

    private static func defineAst(outputDir: String, baseName: String, types: [String]) throws {
        let path = "\(outputDir)/\(baseName).swift"
        let url = URL(fileURLWithPath: path)

        print("Creating file at: \(path)")

        var content = ""

        content += "import Foundation\n"
        content += "import Tokenizer\n\n"

        content += """
            public protocol \(baseName) {
                func accept<V: \(baseName)Visitor, R>(visitor: V) throws -> R where R == V.\(baseName)VisitorReturnType
            }
            """

        content += defineVisitor(baseName: baseName, types: types)

        for type in types {
            let components = type.components(separatedBy: " : ")
            let className = components[0].trimmingCharacters(in: .whitespaces)

            var fieldComponents: [String] = []
            if components.count > 1 {
                let fieldsString = components[1].trimmingCharacters(in: .whitespaces)
                fieldComponents = fieldsString.components(separatedBy: ", ")
            }

            content += defineType(baseName: baseName, className: className, fields: fieldComponents)
        }

        try content.write(to: url, atomically: true, encoding: .utf8)
        print("Successfully generated \(baseName).swift")
    }

    private static func defineVisitor(baseName: String, types: [String]) -> String {
        var result = ""

        result += "public protocol \(baseName)Visitor {\n"
        result += "    associatedtype \(baseName)VisitorReturnType\n"
        result += "    \n"

        for type in types {
            let className = type.components(separatedBy: " : ")[0].trimmingCharacters(in: .whitespaces)
            result += "    func visit\(className)\(baseName)(_ \(baseName.lowercased()): \(className)) throws -> \(baseName)VisitorReturnType\n"
        }

        result += "}\n\n"

        return result
    }

    private static func defineType(baseName: String, className: String, fields: [String]) -> String {
        var result = ""

        result += "public struct \(className): \(baseName) {\n"

        for field in fields {
            let trimmedField = field.trimmingCharacters(in: .whitespaces)
            result += "    public let \(trimmedField)\n"
        }

        if !fields.isEmpty {
            result += "\n"
            result += "    public init("
            let initParams = fields.map { field in
                return field.trimmingCharacters(in: .whitespaces)
            }.joined(separator: ", ")
            result += initParams
            result += ") {\n"

            for field in fields {
                let trimmedField = field.trimmingCharacters(in: .whitespaces)
                let fieldName = trimmedField.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)
                result += "        self.\(fieldName) = \(fieldName)\n"
            }
            result += "    }\n"
        }

        result += """

                public func accept<V: \(baseName)Visitor, R>(visitor: V) throws -> R where R == V.\(baseName)VisitorReturnType {
                    return try visitor.visit\(className)\(baseName)(self)
                }\n
            """

        result += "}\n\n"

        return result
    }
}
