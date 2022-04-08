//
//  ModelData.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 07/04/22.
//

import Foundation
import Combine // buat pake observable object

// An observable object is a custom object for your data that can be bound to a view from storage in SwiftUI’s environment
// SwiftUI watches for any changes to observable objects that could affect a view, and displays the correct version of the view after a change.
final class ModelData: ObservableObject {
    @Published var products: [ProductItem] = load("Products.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("File \(filename) tidak ditemukan!")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("File \(filename) gagal dibuka! Error: \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error)
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
