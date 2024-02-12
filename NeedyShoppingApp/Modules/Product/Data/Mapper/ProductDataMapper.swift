//
//  ProductDataMapper.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 12/02/24.
//

import Foundation

struct ProductDataMapper: DataModelMappingProtocol {
    
    typealias DomainModel = ProductDomainModel
    typealias DataModel = ProductModel
    
    func mapToDataModel(from domainModel: ProductDomainModel) -> ProductModel {
        return ProductModel(id: domainModel.id,
                            title: domainModel.title,
                            price: domainModel.price,
                            category: domainModel.category,
                            description: domainModel.description,
                            image: domainModel.image)
    }
    
    func mapToDomainModel(from dataModel: ProductModel) -> ProductDomainModel {
        return ProductDomainModel(id: dataModel.id,
                                  title: dataModel.title,
                                  price: dataModel.price,
                                  category: dataModel.category,
                                  description: dataModel.description,
                                  image: dataModel.image)
    }
}
