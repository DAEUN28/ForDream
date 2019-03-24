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
    
    var dreamContainers = DreamContainer.sharedInstance
    var dream = Dream()
    
    func fetchContainers(loadingIsFinished: @escaping () -> Void) {
        let base = Base()
        
        if Auth.auth().currentUser != nil {
            base.ref.child("users").child(base.uid!).child("dream").observe(DataEventType.value) { (DataSnapshot) in
                self.dreamContainers.dreamContainers.removeAll()
                
                if DataSnapshot.exists() {
                    let dataTemp = DataSnapshot.value as! [[String:Any]]
                    
                    for (_ , element) in dataTemp.enumerated() {
                        self.dream.detailTxt = element["detailTxt"] as! String
                        self.dream.writedDate = element["writedDate"] as! String
                        self.dream.starStorageIsChecked = element["starStorageIsChecked"] as! Bool
                        self.dreamContainers.dreamContainers.append(self.dream)
                    }
                    
                    self.dreamContainers.dreamContainers = self.ascendingOrder(dream: self.dreamContainers.dreamContainers)
                }
                loadingIsFinished()
            }
        } else {
            print(Error.self)
        }
    }
    
    func updateAction() {
        let base = Base()
        let dreamRef = base.ref.child("users").child(base.uid!).child("dream")
        dreamRef.removeValue()
        
        for (idx, dream) in dreamContainers.dreamContainers.enumerated() {
            saveAction(dream: dream, index: idx)
        }
    }
    
    func saveAction(dream: Dream, index: Int) {
        let base = Base()
        let dreamRef = base.ref.child("users").child(base.uid!).child("dream")
        
        dreamRef.child("\(index)").setValue(["writedDate" : dream.writedDate,
                                             "detailTxt" : dream.detailTxt,
                                             "starStorageIsChecked" : dream.starStorageIsChecked])
    }
    
    func removeAction(removeDream: Dream) {
        dreamContainers.dreamContainers.removeAll(where: {$0.writedDate == removeDream.writedDate})
        updateAction()
    }
    
    func removeAllAction() {
        dreamContainers.dreamContainers.removeAll()
        updateAction()
    }
    
    func ascendingOrder(dream: [Dream]) -> [Dream] {
        return dream.sorted(by: { (d1, d2) -> Bool in
            d1.writedDate < d2.writedDate
            
        })
    }
    
    func descendingOrder(dream: [Dream]) -> [Dream] {
        return dream.sorted(by: { (d1, d2) -> Bool in
            d1.writedDate > d2.writedDate
        })
    }
}
