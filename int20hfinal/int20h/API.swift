//
//  API.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/24/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import Foundation

struct ComponentResponse: Decodable {
    let data: [Component]
    let errors: [String]
    let result: Bool
}

struct Component: Decodable {
    let Description: String
}

struct API {
    
    private static let baseURL = "http://192.168.33.92:8000"
    
    static let sugar = "Sugar"
    static let water = "Water"
    static let glukosa = "Glukoza"
    static let cofein = "Cofein"
    static let taurin = "Taurin"
    static let aspartam = "Aspartam"
    static let chocolate = "Chocolate"
    static let cacao = "Cacao"
    static let arahis = "Arahis"
    static let soya = "Soya"
    
    static func getAllComponents(withCompletion completion: @escaping (Error?, [String]) -> Void) {
        completion(nil, [sugar, water, glukosa, cofein, taurin, aspartam, chocolate, cacao, arahis, soya])
    }
    
    static func getComponents(for barcode: String, withCompletion completion: @escaping (Error?, [String]) -> Void) {
        switch barcode {
        case "4823063111829":
            completion(nil, [sugar])
        case "2999300039859":
            completion(nil, [water, glukosa, taurin])
        case "9002490100070":
            completion(nil, [sugar, water, glukosa, cofein, taurin])
        case "5449000008046":
            completion(nil, [sugar])
        default:
            completion(nil, [])
        }
    }
    
}
