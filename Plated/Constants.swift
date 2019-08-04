//
//  Constants.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

struct Constants {
    
    static var networkToken = "uDTZnGR4tFGLo1Pmizvi4Att"
    static var menusURL = "https://plated-coding-challenge.herokuapp.com/v1/menus.json"
    static func recipesURL(with id: Int) -> String {
        return "https://plated-coding-challenge.herokuapp.com/v1/menus/\(id)/recipes.json"
    }
    static let demoMessage = "This is just a demo app, sorry!"
    static let errorTitle = "Error"
    static let platedFontName = "Avenir-Heavy"
    static let fetchImageFailureTitle = "Failed to fetch image:"
    static let somethingWentWrong = "Something went wrong."
    static let recents = "Recents"
    
    
}
