//
//  DreamContainer.swift
//  ForDream
//
//  Created by baby1234 on 25/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class DreamContainer {
    
    static let sharedInstance = DreamContainer()
    
    var ref = Database.database().reference()
    var dreamContainers = [Dream]()
    
    func updateDreamIdx() {
        let uid = Auth.auth().currentUser?.uid
        
//        if self.dreamContainers.count != ref.child("users").child(uid).child("dream")
    }
}
