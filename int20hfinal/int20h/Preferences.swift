//
//  Preferences.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/23/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import Foundation

struct Preferences {
    
    static func save(undesired products: [String]) {
        UserDefaults.standard.set(products.joined(separator: "~"), forKey: "undesired")
    }
    
    static var undesiredProducts: [String] {
        return UserDefaults.standard.string(forKey: "undesired")?.split(separator: "~").map({ String($0) }) ?? []
    }
    
}
