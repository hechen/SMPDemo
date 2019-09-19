import XCTest
import class Foundation.Bundle
import CommandLineToolCore
import Files

final class CommandLineToolTests: XCTestCase {
    func testExample() throws {
        // Setup a temp test folder that can be used as a sandbox
        let tempFolder = Folder.temporary
        let testFolder = try tempFolder.createSubfolderIfNeeded(
            withName: "CommandLineToolTests"
        )
        
        // Empty the test folder to ensure a clean state
        try testFolder.empty()
        
        // Make the temp folder the current working folder
        let fileManager = FileManager.default
        fileManager.changeCurrentDirectoryPath(testFolder.path)
        
        // Create an instance of the command line tool
        let tool = CommandLineTool(arguments: [testFolder.path, "Hello.swift"])
        
        // Run the tool and assert that the file was created
        try tool.run()
        XCTAssertNotNil(try? testFolder.file(named: "Hello.swift"))
    }
    
    /// Returns path to the built products directory.
    var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
        #else
        return Bundle.main.bundleURL
        #endif
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
