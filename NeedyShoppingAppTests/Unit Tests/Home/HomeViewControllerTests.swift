//
//  HomeViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class HomeViewControllerTests: XCTestCase {
    var viewControllerUnderTest: HomeViewController!
    var mockCategoreies: [String] = ["testCategory"]
    override func setUp() {
        super.setUp()
    }
    
    func testLoadedView() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        XCTAssertNotNil(viewControllerUnderTest)
        XCTAssertNotNil(viewControllerUnderTest.homeTableView)
    }
    
    func testCategoryFetch() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.invokeCategoryFetch()
        XCTAssertTrue(viewModel.fetchProductCategoriesCalled)
    }

    func testLogoutButtonTapped() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        let mockApplication = MockApplication()
        viewControllerUnderTest.application = mockApplication
        let mockWindow = UIWindow()
        viewControllerUnderTest.view = UIView()
        mockWindow.addSubview(viewControllerUnderTest.view)

        // Act
        viewControllerUnderTest.logoutButtonTapped(UIBarButtonItem())

        // Assert
        XCTAssertTrue(mockApplication.setRootViewControllerCalled)
        XCTAssertNotNil(mockApplication.mockRootViewController as? LoginViewController)
        XCTAssertEqual(mockApplication.mockTransition, .transitionFlipFromRight)
        XCTAssertEqual(mockApplication.mockWindow, mockWindow)
    }
    
    func testFailedRootViewcontroller() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        let mockApplication = MockApplication()
        viewControllerUnderTest.application = mockApplication
        var mockWindow: UIWindow?
        viewControllerUnderTest.view = UIView()
        mockWindow?.addSubview(viewControllerUnderTest.view)

        viewControllerUnderTest.logoutButtonTapped(UIBarButtonItem())

        XCTAssertFalse(mockApplication.setRootViewControllerCalled)
        XCTAssertNil(mockApplication.mockRootViewController as? LoginViewController)
        XCTAssertNotEqual(mockApplication.mockTransition, .transitionFlipFromRight)
    }
    
    func testNumberOfRowsInSection() {
        let emptyCatgories: [String] = []
        let viewModel = MockHomeViewModel(emptyCatgories)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        if let tableView = viewControllerUnderTest.homeTableView {
            let numberOfRows = viewControllerUnderTest.tableView(tableView, numberOfRowsInSection: 0)
            
            XCTAssertEqual(numberOfRows, viewModel.numberOfRows())
        }
    }
    
    func testZeroRowsInSection() {
        let emptyCatgories: [String] = []
        let viewModel = MockHomeViewModel(emptyCatgories)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        if let tableView = viewControllerUnderTest.homeTableView {
            let numberOfRows = viewControllerUnderTest.tableView(tableView, numberOfRowsInSection: 0)
            
            XCTAssertEqual(numberOfRows, 0)
        }
    }

    func testCellForRowAtIndex() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        if let tableView = viewControllerUnderTest.homeTableView {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = viewControllerUnderTest.tableView(tableView, cellForRowAt: indexPath)
            
            XCTAssertTrue(cell is CategoryTableViewCell)
            XCTAssertEqual((cell as? CategoryTableViewCell)?.categoryLabel.text, "Testcategory")
        }
    }
    
    func testFavouriteButtonTapped() {
        let viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        if let tableView = viewControllerUnderTest.homeTableView {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = viewControllerUnderTest.tableView(tableView, cellForRowAt: indexPath)
            XCTAssertTrue(cell is CategoryTableViewCell)
            let favouriteButton = (cell as? CategoryTableViewCell)?.favouriteButton
            favouriteButton?.sendActions(for: .touchUpInside)
        }
    }

    func testDidSelectRowAtIndex() {
        var viewModel = MockHomeViewModel(mockCategoreies)
        viewControllerUnderTest = HomeViewController.instantiate(creator: { coder in
            HomeViewController(coder: coder, homeViewModel: viewModel)
        })
        viewControllerUnderTest.loadView()
        
        let indexPath = IndexPath(row: 0, section: 0)
        if let tableView = viewControllerUnderTest.homeTableView {
            viewControllerUnderTest.tableView(tableView, didSelectRowAt: indexPath)
        }
        XCTAssertEqual(viewModel.categoryTitle(for: indexPath), "testCategory")
        let emptyCatgories: [String] = []
        viewModel = MockHomeViewModel(emptyCatgories)
        if let tableView = viewControllerUnderTest.homeTableView {
            viewControllerUnderTest.tableView(tableView, didSelectRowAt: indexPath)
        }
        XCTAssertEqual(viewModel.numberOfRows(), 0)
    }
    /*
    func testCellDequeueFails() {
        // Arrange
        let mockViewModel = MockHomeViewModel(fetchCategoriesUseCase: MockFetchCategoriesUseCase())
        viewControllerUnderTest.homeViewModel = mockViewModel

        // Create a mock table view that fails to dequeue a cell
        let mockTableView = MockTableView()
        mockTableView.dequeueCellReturnNil = true

        // Set the mock table view as the homeTableView
        viewControllerUnderTest.homeTableView = mockTableView

        // Act
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewControllerUnderTest.tableView(mockTableView, cellForRowAt: indexPath)

        // Assert
        XCTAssertTrue(cell is UITableViewCell)
    }
    
    func testTableViewReload() {
        let tableview = MockTableView()
        viewControllerUnderTest.homeTableView = tableview
        viewControllerUnderTest.invokeCategoryFetch()
        XCTAssertFalse(tableview.reloadDataCalled)
        viewControllerUnderTest.homeTableView.reloadData()
        XCTAssertTrue(tableview.reloadDataCalled)
    }
    */
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }
}

