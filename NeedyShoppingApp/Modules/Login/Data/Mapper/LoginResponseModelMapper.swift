//
//  LoginResponseModelMapper.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 12/02/24.
//

import Foundation

struct LoginResponseModelMapper: DataModelMappingProtocol {
    
    typealias DomainModel = LoginResponseDomainModel
    typealias DataModel = LoginResponse
    
    func mapToDataModel(from domainModel: LoginResponseDomainModel) -> LoginResponse {
        return LoginResponse(token: domainModel.token)
    }
    
    func mapToDomainModel(from dataModel: LoginResponse) -> LoginResponseDomainModel {
        return LoginResponseDomainModel(token: dataModel.token)
    }

}
