//
//  DreamContainer.swift
//  ForDream
//
//  Created by baby1234 on 25/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class DreamContainer: Codable{
    
    var writedDate:String
    var dream:Dream

    init() {
        writedDate = ""
        dream = Dream()
    }
    
}

class DreamContainers {
    static let sharedInstance = DreamContainers()
    
    var dreamContainers = [String:Dream]()
}
