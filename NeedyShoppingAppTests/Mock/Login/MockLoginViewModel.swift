//
//  MockLoginViewModel.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockLoginViewModel: LoginViewModelProtocol {

    var success: Bool
    var didCallLogin = false
    
    init(success: Bool) {
        self.success = success
    }
    
    func login(withUsername username: String, _ password: String, completion: @escaping (Bool) -> Void) {
        didCallLogin = true
        completion(success)
    }
}
