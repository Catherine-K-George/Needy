//
//  LoginDataMapper.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 05/02/24.
//

import Foundation

struct LoginDataModelMapper {
    static func mapToDataRequestModel(from domainModel: LoginRequestDomainModel) -> LoginRequest {
        return LoginRequest(username: domainModel.username, password: domainModel.password)
    }
    
    static func mapToDomainRequestModel(from dataModel: LoginRequest) -> LoginRequestDomainModel {
        return LoginRequestDomainModel(username: dataModel.username, password: dataModel.password)
    }
    
    static func mapToDataResponseModel(from domainModel: LoginResponseDomainModel) -> LoginResponse {
        return LoginResponse(token: domainModel.token)
    }
    
    static func mapToDomainResponseModel(from dataModel: LoginResponse) -> LoginResponseDomainModel {
        return LoginResponseDomainModel(token: dataModel.token)
    }
}
