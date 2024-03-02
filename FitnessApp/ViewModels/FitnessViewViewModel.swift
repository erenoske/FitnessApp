//
//  FitnessViewViewModel.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FitnessViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    
    init() {}
    
    func delete(id: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func resetAllDoneStatus() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(String(describing: error))")
                    return
                }

                for document in documents {
                    let documentRef = db.collection("users").document(uid).collection("todos").document(document.documentID)
                    documentRef.updateData(["isDone": false])
                }
            }
    }
}
