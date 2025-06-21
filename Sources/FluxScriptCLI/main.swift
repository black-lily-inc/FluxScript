import Foundation
import FluxScript

struct FluxScriptCLI {
    static func main() {
        let arguments = CommandLine.arguments
        
        let args = Array(arguments.dropFirst())
        
        if args.isEmpty {
            startREPL()
        } else {
            handleArguments(args)
        }
    }
    
    static func startREPL() {
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
            
            processFluxScriptInput(trimmedInput, lineNumber: lineNumber)
            lineNumber += 1
        }
    }
    
    static func handleArguments(_ args: [String]) {
        let firstArg = args[0]
        
        if firstArg.hasSuffix(".flx") {
            runFluxScriptFile(firstArg)
        } else {
            print("Usage: fluxscript [file.flx]")
            print("  No arguments: Start interactive REPL")
            print("  file.flx: Execute FluxScript file")
        }
    }
    
    static func runFluxScriptFile(_ filename: String) {
        do {
            let content = try String(contentsOfFile: filename)
            print("Executing FluxScript file: \(filename)")
            print("----------------------------------------")
            
            processFluxScriptInput(content, lineNumber: 1)
            
        } catch {
            print("Error reading file '\(filename)': \(error.localizedDescription)")
        }
    }
    
    static func processFluxScriptInput(_ input: String, lineNumber: Int) {
        print("[\(lineNumber)] Input received: \(input)")
        print("[\(lineNumber)] Output: (FluxScript interpreter not implemented yet)")
    }
    
    static func printHelp() {
        print("FluxScript REPL Commands:")
        print("  help    - Show this help message")
        print("  clear   - Clear the screen")
        print("  exit    - Exit the REPL")
        print("  quit    - Exit the REPL")
        print("  exec    - Import & Execute a .flx file")
        print("")
        print("Enter FluxScript code to execute it.")
    }
    
    static func clearScreen() {
        print("\u{001B}[2J\u{001B}[H", terminator: "")
    }
}

FluxScriptCLI.main()
