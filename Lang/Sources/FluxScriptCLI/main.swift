import Foundation
import FluxScript

struct FluxScriptCLI {
    let fluxScript = FluxScript()
    
    func run() throws {
        let arguments = CommandLine.arguments
        let args = Array(arguments.dropFirst())
        
        if args.isEmpty {
            try startREPL()
        } else {
            try handleArguments(args)
        }
    }
    
    func startREPL() throws {
        print("FluxScript Interactive REPL")
        print("Type 'exit' or 'quit' to exit, 'help' for help")
        print("----------------------------------------")
        
        var lineNumber = 1
        
        while true {
            print("> ", terminator: "")
            
            guard let input = readLine() else {
                print("\nGoodbye!")
                break
            }
            
            let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Handle special commands
            switch trimmedInput.lowercased() {
            case "exit", "quit":
                print("Goodbye!")
                return
            case "help":
                printHelp()
                continue
            case "clear":
                clearScreen()
                continue
            case "":
                continue
            default:
                break
            }
            
            try processFluxScriptInput(trimmedInput, lineNumber: lineNumber)
            lineNumber += 1
        }
    }
    
    func handleArguments(_ args: [String]) throws {
        let firstArg = args[0]
        
        if firstArg.hasSuffix(".flx") {
            try runFluxScriptFile(firstArg)
        } else {
            print("Usage: fluxscript [file.flx]")
            print("  No arguments: Start interactive REPL")
            print("  file.flx: Execute FluxScript file")
        }
    }
    
    func runFluxScriptFile(_ filename: String) throws {
        do {
            let content = try String(contentsOfFile: filename)
            print("Executing FluxScript file: \(filename)")
            print("----------------------------------------")
            
            try fluxScript.run(input: content)
        } catch {
            print("Error reading file '\(filename)': \(error.localizedDescription)")
        }
    }
    
    func processFluxScriptInput(_ input: String, lineNumber: Int) throws {
        print("[\(lineNumber)] Input received: \(input)")
        try fluxScript.run(input: input)
    }
    
    func printHelp() {
        print("FluxScript REPL Commands:")
        print("  help    - Show this help message")
        print("  clear   - Clear the screen")
        print("  exit    - Exit the REPL")
        print("  quit    - Exit the REPL")
        print("  exec    - Import & Execute a .flx file")
        print("")
        print("Enter FluxScript code to execute it.")
    }
    
    func clearScreen() {
        print("\u{001B}[2J\u{001B}[H", terminator: "")
    }
}

// Create and run the CLI
let cli = FluxScriptCLI()
try cli.run()
