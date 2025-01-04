import Foundation

public enum TokenizerError: Error {
    case invalidCharacter
    case unterminatedString
    case invalidEscapeCharacter
}

public enum TokenType {
    case string
}

public struct Token {
    public let literal: String
    public let type: TokenType
    public  let line: Int
    public let start: Int
    public let end: Int
}

public class Tokenizer {
    let source: String
    var tokens: [Token] = []
    var current: Int = 0
    var start:  Int = 0
    var line: Int = 0
    
    public init(source: String) {
        self.source = source
    }
    
    public func scanTokens() throws -> [Token] {
        current = 0
        while !isAtEnd() {
            start = current
            try scanToken()
        }
        
        return tokens
    }
    
    func scanToken() throws {
        let literal = advance()
        print(literal)
        
        switch literal {
            case "\n":
                line += 1
            case "\"":
                try string()
            default:
                throw TokenizerError.invalidCharacter
        }
    }
    
    @discardableResult
    func advance() -> Character {
        if isAtEnd() {
            return "\0"
        }
        
        let index = source.index(source.startIndex, offsetBy: current)
        
        current += 1
        
        return source[index]
    }
    
    func peek() -> Character {
        if isAtEnd() {
            return "\0"
        }
        
        let index = source.index(source.startIndex, offsetBy: current)
        return source[index]
    }
    
    func isAtEnd() -> Bool {
        return current >= source.count
    }
    
    func addToken(type tokenType: TokenType, literal: String) {
        let token = Token(literal: literal, type: tokenType, line: line, start: start, end: current)
        tokens.append(token)
    }
    
    func string() throws {
        var literal: String = ""
        var isQuoted: Bool = false
        while !isAtEnd() {
            let character = advance()
            if character == "\n" {
                line += 1
            }
            
            // Add support for escaping characters inside of our strings
            if character == "\\" {
                let nextCharacter = peek()
                if nextCharacter == "n" {
                    advance()
                    literal += "\n"
                } else if nextCharacter == "t" {
                    advance()
                    literal += "\t"
                } else if nextCharacter == "\\" {
                    advance()
                    literal += "\\"
                } else if nextCharacter == "\"" {
                   advance()
                    literal += "\""
                } else {
                    throw TokenizerError.invalidEscapeCharacter
                }
                continue
            }
            
            if character != "\"" {
                literal = "\(literal)\(character)"
            }
            
            if character == "\"" {
                advance() // Ensure  we don't add the last one
                isQuoted.toggle()
                break
            }
        }
        
        if isQuoted {
            addToken(type: .string, literal: literal)
        } else {
            throw TokenizerError.unterminatedString
        }
    }
}
