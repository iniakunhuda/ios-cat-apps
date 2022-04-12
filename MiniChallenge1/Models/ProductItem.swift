//
//  ProductItem.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 07/04/22.
//

import Foundation
import SwiftUI

enum ProductCategory: Decodable, Equatable {
    case Food, Hygiene, Health, Others
    case unknown(value: String)
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
            case "Food": self = .Food
            case "Hygiene": self = .Hygiene
            case "Health": self = .Health
            case "Others": self = .Others
            default:
                self = .unknown(value: status ?? "unknown")
        }
    }
}

struct ProductInfo: Decodable {
    var name: String
    var value: String
}


struct ProductItem: Decodable {
    var id: String
    var category: ProductCategory?
    var title: String
    var subtitle: String
    var description: String
    var price: String
    var link: String
    var isFavorited: Bool
    var info: [ProductInfo]
    
    private var imageName: String
    var image: UIImage {
        UIImage(imageLiteralResourceName: imageName)
    }
}

