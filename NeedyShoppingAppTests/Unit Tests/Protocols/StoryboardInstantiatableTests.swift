//
//  StoryboardInstantiatableTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

class MockStoryboard: UIStoryboard {
//    override func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
//            return MockLoginViewController()
//        
//    }
}

final class StoryboardInstantiatableTests: XCTestCase {
//    func testInstanitateSuccess() {
//        let vc = LoginViewController.instantiateFromStoryboard()
//        XCTAssertNotNil(vc)
//    }
//    
//    func testInstanitateFromCustomStoryboard() {
//        let vc = MockLoginViewController.instantiateFromStoryboard(storyboard: MockStoryboard())
//        XCTAssertNotNil(vc)
//    }
    /*
    func testInstanitateFail() {
        expectFatalError(expectedMessage: "Failed to instantiate view controller from storyboard.") {
            let vc = FavouritesViewController.instantiateFromStoryboard()
        }
        
    }*/
    
}

/*
 
 struct FatalErrorUtil {
     // 1
     static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
     // 2
     private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
     // 3
     static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
         fatalErrorClosure = closure
     }
     // 4
     static func restoreFatalError() {
         fatalErrorClosure = defaultFatalErrorClosure
     }
     
     func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
         FatalErrorUtil.fatalErrorClosure(message(), file, line)
     }
     
 }


 extension XCTestCase {
     func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
             let expectation = self.expectation(description: "expectingFatalError")
             var assertionMessage: String? = nil
             FatalErrorUtil.replaceFatalError { message, _, _ in
                 print("Expectation fulfilled with message: \(assertionMessage ?? "nil")")

                 assertionMessage = message
                 expectation.fulfill()
                 fatalError()  // Terminate the program
             }

 //            DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

             waitForExpectations(timeout: 5) { _ in
                 print("Waiting completed. Assertion message: \(assertionMessage ?? "nil")")

                 XCTAssertEqual(assertionMessage, expectedMessage)
                 FatalErrorUtil.restoreFatalError()
             }
         }

    
 }

*/

