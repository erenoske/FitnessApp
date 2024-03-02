//
//  LoginViewViewModel.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }

        Auth.auth().signIn(withEmail: emailText, password: passwordText)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !emailText.trimmingCharacters(in: .whitespaces).isEmpty, !passwordText.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all fields"
            
            return false
        }
        
        guard emailText.contains("@") && emailText.contains(".") else {
            
            errorMessage = "Please enter valid email."
            
            return false
        }
        
        return true
    }
}
