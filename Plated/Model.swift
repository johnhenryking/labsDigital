//
//  Menu.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit
import RealmSwift

struct Menu: Decodable {
    
    var id: Int?
    var title: String?
    var recipes: [Recipe]?
    
}

@objcMembers class Recipe: Object, Decodable {
    
    var id: Int?
    dynamic var name: String?
    dynamic var descriptor: String?
    dynamic var image: String?
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
}

extension Recipe {
    
    internal func writeToRealm() {
        try! NetworkManager.shared.realm.write {
            NetworkManager.shared.realm.add(self)
            
        }
    }
    
    internal func deleteFromRealm() {
        try! NetworkManager.shared.realm.write {
            NetworkManager.shared.realm.delete(self)
        }
    }
}



