//
//  RegisterView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI

enum FocusTextRegister {
    case name, email, password
}

struct RegisterView: View {
    
    @FocusState private var focusField: FocusTextRegister?
    @StateObject var viewModel = RegisterViewViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        let textFieldColor = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.white
            VStack {
                
                VStack {
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 65)
                    
                    TextField("Username", text: $viewModel.nameText)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .focused($focusField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .email
                        }
                    
                    TextField("Email", text: $viewModel.emailText)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                        .focused($focusField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .password
                        }
                    
                    SecureField("Password", text: $viewModel.passwordText)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .focused($focusField, equals: .password)
                        .submitLabel(.done)
                        .onSubmit {
                            //Function
                        }
                    Button {
                        viewModel.register()
                    } label: {
                       Text("Create Account")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.all, 12)
                            .background(Color.red)
                            .cornerRadius(50)
                    }
                    .padding(.top, 10)
                }
                .offset(y: -30)
            }
            .padding()
            .offset(y: -100)
        }
    }

#Preview {
    RegisterView()
}
