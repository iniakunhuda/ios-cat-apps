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

struct ProductItem: Decodable {
    var id: String
    var category: ProductCategory?
    var title: String
    var subtitle: String
    var description: String
    var price: Int
    var isFavorited: Bool
    
    private var imageName: String
    var image: UIImage {
        UIImage(imageLiteralResourceName: imageName)
    }
}

//struct FoodList {
//
//    static let topTen = [
//
//        // harus sesuai urutan bor atributnya
//        Food(imageName: "image1",
//             title: "Membuat Resep Nasi Goreng Jawa",
//             description: desc,
//             uploadDate: "22 Feb 2022",
//             rating: 3,
//             url: URL(string: "https://www.youtube.com/watch?v=i6yHVLgrELQ")!),
//
//        Food(imageName: "image2",
//             title: "Buat Rendang di Rumah",
//             description: desc,
//             uploadDate: "15 Feb 2022",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=wENa8twuT6E")!),
//
//        Food(imageName: "image3",
//             title: "Bikin Nasi Goreng Maknyus!",
//             description: desc,
//             uploadDate: "07 Feb 2022",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=Js9FXCkn798")!),
//
//        Food(imageName: "image4",
//             title: "Ayam Bakar ala Restoran Bintang 5",
//             description: desc,
//             uploadDate: "02 Feb 2022",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=j9a9EB0pGTo")!),
//
//        Food(imageName: "image5",
//             title: "Cara Bikin Bakso Murah Meriah",
//             description: desc,
//             uploadDate: "15 Jan 2022",
//             rating: 4,
//             url: URL(string: "https://www.youtube.com/watch?v=rLt-QGggJ_0")!),
//
//        Food(imageName: "image6",
//             title: "Resep Nasi Goreng Mawut",
//             description: desc,
//             uploadDate: "13 Jan 2022",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=zMX70kMeN_k")!),
//
//        Food(imageName: "image7",
//             title: "Cobain Gudeg Mudah & Enak",
//             description: desc,
//             uploadDate: "01 Jan 2022",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=3tGj1B90Uns")!),
//
//        Food(imageName: "image8",
//             title: "Resep Gulai Kambing Anti Amis, No 5 Bikin Penasaran!",
//             description: desc,
//             uploadDate: "17 Des 2021",
//             rating: 5,
//             url: URL(string: "https://www.youtube.com/watch?v=37E5irjRDNk")!),
//
//    ]
//
//}

