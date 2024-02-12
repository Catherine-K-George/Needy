//
//  DataModelMappingProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 12/02/24.
//

import Foundation

protocol DataModelMappingProtocol {
    associatedtype DomainModel
    associatedtype DataModel

    func mapToDataModel(from domainModel: DomainModel) -> DataModel
    func mapToDomainModel(from dataModel: DataModel) -> DomainModel
}
