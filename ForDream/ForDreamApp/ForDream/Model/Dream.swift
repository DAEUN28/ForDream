//
//  Dream.swift
//  ForDream
//
//  Created by baby1234 on 18/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct Dream {
    var detailTxt: String = ""
    var starStorageIsChecked: Bool = false
    var writedDate: String = ""
}

class DreamContainer {
    static let sharedInstance = DreamContainer()
    var dreamContainers: [Dream] = [Dream]()
    
    private init() {
        
    }
}
