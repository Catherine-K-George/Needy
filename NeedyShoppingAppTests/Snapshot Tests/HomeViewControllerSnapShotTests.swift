//
//  HomeViewControllerSnapShotTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

@testable import NeedyShoppingApp
import UIKit

final class HomeViewControllerSnapShotTests: SnapshotTestCase {
    let mockCategories = ["testCategory"]

    override func setUp() {
        super.setUp()
        recordMode = false

    }
    
    func testViewController_WhenProvidedTitle() {
        let expectedUsername = "testUser"
        let mockViewModel = MockHomeViewModel(mockCategories)
        UserDefaults.standard.set(expectedUsername, forKey: StringConstants.UserDefaults.username)
        let sut = HomeViewController.instantiate { coder in
            HomeViewController(coder: coder, homeViewModel: mockViewModel)
        }
        sut.loadView()
        sut.setHomeHeader()
        verifyViewController(sut)
    }
    
    func testViewController_WhenProvidedACategoryList_ShouldDisplayTheCategoryList() {
        let mockViewModel = MockHomeViewModel(mockCategories)
        let sut = HomeViewController.instantiate { coder in
            HomeViewController(coder: coder, homeViewModel: mockViewModel)
        }
        sut.loadView()
        sut.homeTableView?.reload()
        verifyViewController(sut)
    }
    
    func testViewController_WhenThereIsNoCategory_ShouldDisplayEmptyTableView() {
        let emptyCategoryList: [String] = []
        let mockViewModel = MockHomeViewModel(emptyCategoryList)
        let sut = HomeViewController.instantiate { coder in
            HomeViewController(coder: coder, homeViewModel: mockViewModel)
        }
        sut.loadView()
        sut.homeTableView?.reload()
        verifyViewController(sut)
    }
}
