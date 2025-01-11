import Tokenizer

let source = """
"this is a test"
"string 2"
"Bob Said: \\"Hi, How are you?\\""
"
Bob Said:
\\"What are you doing?\\"
"
"""

let source2 = """
123
123.4
"""

let source3 = """
+ - * / ** % ^
"""

let fullSource = "\(source)\n\(source2)\n\(source3)"

let tokenizer = Tokenizer(source: fullSource)
print(try tokenizer.scanTokens())
