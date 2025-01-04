import Tokenizer

let source = """
"this is a test"
"string 2"
"Bob Said: \"Hi, How are you?\""
"""

let tokenizer = Tokenizer(source: source)
print(try tokenizer.scanTokens())
