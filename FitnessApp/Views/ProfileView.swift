//
//  ProfileView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    // Avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.red)
                        .frame(width: 125, height: 125)
                        .padding()
                    
                    // Info: Name, Email Member since
                    
                    VStack(alignment: .center) {
                        HStack {
                            Text("Name: ")
                            Text(user.name)
                        }
                        .padding()
                        HStack {
                            Text("Email: ")
                            Text(user.email)
                        }
                        .padding()
                        HStack {
                            Text("Member Since: ")
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                    }
                    
                    // Sign out
                    Button {
                        viewModel.logOut()
                    } label: {
                       Text("Log Out")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.red)
                            .padding()
                            .cornerRadius(50)
                    }
                } else {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            .navigationTitle("Profile")
            .padding()
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

#Preview {
    ProfileView()
}
