//
//  LoginRequestModelMapper.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 05/02/24.
//

import Foundation

struct LoginRequestModelMapper: DataModelMappingProtocol {
    
    typealias DomainModel = LoginRequestDomainModel
    typealias DataModel = LoginRequest
    
    func mapToDataModel(from domainModel: LoginRequestDomainModel) -> LoginRequest {
        return LoginRequest(username: domainModel.username, password: domainModel.password)
    }
    
    func mapToDomainModel(from dataModel: LoginRequest) -> LoginRequestDomainModel {
        return LoginRequestDomainModel(username: dataModel.username, password: dataModel.password)
    }
}
