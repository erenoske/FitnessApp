//
//  RegisterViewViewModel.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var nameText = ""
    @Published var emailText = ""
    @Published var passwordText = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: nameText, email: emailText, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        guard !nameText.trimmingCharacters(in: .whitespaces).isEmpty,
              !emailText.trimmingCharacters(in: .whitespaces).isEmpty,
              !passwordText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard emailText.contains("@") && emailText.contains(".") else {
            return false
        }
        
        guard passwordText.count >= 6 else {
            return false
        }
        
        return true
    }
}
