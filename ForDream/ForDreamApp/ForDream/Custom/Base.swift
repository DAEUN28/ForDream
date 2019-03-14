//
//  Base.swift
//  ForDream
//
//  Created by baby1234 on 16/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Firebase

class Base {
    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
}
