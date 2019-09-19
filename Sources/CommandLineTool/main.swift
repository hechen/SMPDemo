import CommandLineToolCore

let tool = CommandLineTool()
do {
    try tool.run()
} catch {
    print("Command Line Tool Throw a exception!")    
}