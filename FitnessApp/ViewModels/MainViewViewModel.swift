//
//  MainViewModel.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var currentUserName: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        // Weak Self for the memory leak
        // State managment
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
                
                //Get current user id
                guard let uId = user?.uid else {
                    return
                }
                
                let db = Firestore.firestore()
                
                db.collection("users").document(uId).getDocument { snapshot, error in
                    guard let data = snapshot?.data(), error == nil else {
                        return
                    }
                    
                    self?.currentUserName = data["name"] as? String ?? ""
                }
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
