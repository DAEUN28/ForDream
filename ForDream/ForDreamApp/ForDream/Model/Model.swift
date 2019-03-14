//
//  model.swift
//  ForDream
//
//  Created by baby1234 on 08/03/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import Firebase

class Model {
    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    var dreamContainer = DreamContainer.sharedInstance
    
    func updateContainers() {
        ref.child("users").child(uid!).child("dream").observe(DataEventType.value) { (DataSnapshot) in
            let valueTemp = DataSnapshot.value
            let keyTemp = DataSnapshot.key
            
            print(valueTemp!)
            print("---------")
            print(keyTemp)
        }
    }
    
    func saveAction(writedDate:String ,dream: Dream) {
        let writingDateRef = ref.child("users").child(uid!).child("dream").child(writedDate)
        
        writingDateRef.child("detailTxt").setValue(dream.detailTxt)
        writingDateRef.child("starStorageIsChecked").setValue(dream.starStorageIsChecked)
    }
}
