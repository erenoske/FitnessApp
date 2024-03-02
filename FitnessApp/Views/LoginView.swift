//
//  LoginView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI

enum FocusTextLogin {
    case email, password
}

struct LoginView: View {
    
    @FocusState private var focusField: FocusTextLogin?
    @StateObject var viewModel = LoginViewViewModel()
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        
        let textFieldColor = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.white
        
        NavigationView {
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(Color.red)
                        .rotationEffect(Angle(degrees: 15))
                }
                
                .frame(width: UIScreen.main.bounds.width * 3, height: 250)
                
                Image("fitnessLogo")
                
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(Color.red)
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
                    viewModel.login()
                } label: {
                   Text("Log In")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.all, 12)
                        .background(Color.red)
                        .cornerRadius(50)
                }
                .padding(.top, 10)
                Spacer()
                Divider()
                Spacer()
                HStack {
                    Text("New around here.")
                    Spacer()
                    NavigationLink("Create An Account",
                                   destination: RegisterView())
                    .foregroundColor(.red)
                }
            }
            .padding()
            .offset(y: -100)
        }
        .accentColor(.red)
    }
}

#Preview {
    LoginView()
}
