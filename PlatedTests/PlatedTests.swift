//
//  PlatedTests.swift
//  PlatedTests
//
//  Created by User on 12/18/18.
//  Copyright © 2018 Jonathan King. All rights reserved.
//

import XCTest
@testable import Plated

class PlatedTests: XCTestCase {
    
    func testReuseIdentifier() {
        XCTAssertEqual(Constants.networkToken, "uDTZnGR4tFGLo1Pmizvi4Att")
        XCTAssertEqual(Constants.menusURL, "https://plated-coding-challenge.herokuapp.com/v1/menus.json")
        XCTAssertEqual(Constants.reuseIdentifier, "Cell")
    }
    
    
}
