//
//  TabbarViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 19/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class TabbarViewControllerTests: XCTestCase {
    var viewControllerUnderTest: TabbarViewController!
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = TabbarViewController.instantiateFromStoryboard()
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
    }
    
    func testLoadedView() {
        XCTAssertNotNil(viewControllerUnderTest)
        XCTAssertEqual(viewControllerUnderTest.tabBar.tintColor, UIColor.black)
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }
}
