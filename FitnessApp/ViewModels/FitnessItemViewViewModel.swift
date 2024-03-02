//
//  FitnessItemViewViewModel.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


// ViewModel for list of items view
class FitnessItemViewViewModel: ObservableObject {
    init() {}
    
    func togleIsDone(item: FitnessItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
}
