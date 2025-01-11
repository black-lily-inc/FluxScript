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

let tokenizer = Tokenizer(source: source)
print(try tokenizer.scanTokens())
