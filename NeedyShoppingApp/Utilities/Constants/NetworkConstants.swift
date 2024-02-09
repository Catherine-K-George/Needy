//
//  NetworkConstants.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

enum HTTPMethods: String {
    case GET
    case POST
}

struct NetworkConstants {
    static let baseURL = "https://fakestoreapi.com"
    
    struct Endpoints {
        static let login = "/auth/login"
        static let categories = "/products/categories"
        static let products = "/products/category/%@"
    }
}

