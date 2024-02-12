//
//  LoginDataMapper.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 05/02/24.
//

import Foundation

struct LoginRequestModelMapper: DataModelMappingProtocol {
    
    typealias DomainModel = LoginRequestDomainModel
    typealias DataModel = LoginRequest
    
    static func mapToDataModel(from domainModel: LoginRequestDomainModel) -> LoginRequest {
        return LoginRequest(username: domainModel.username, password: domainModel.password)
    }
    
    static func mapToDomainModel(from dataModel: LoginRequest) -> LoginRequestDomainModel {
        return LoginRequestDomainModel(username: dataModel.username, password: dataModel.password)
    }
}

struct LoginResponseModelMapper: DataModelMappingProtocol {
    
    typealias DomainModel = LoginResponseDomainModel
    typealias DataModel = LoginResponse
    
    static func mapToDataModel(from domainModel: LoginResponseDomainModel) -> LoginResponse {
        return LoginResponse(token: domainModel.token)
    }
    
    static func mapToDomainModel(from dataModel: LoginResponse) -> LoginResponseDomainModel {
        return LoginResponseDomainModel(token: dataModel.token)
    }

}
