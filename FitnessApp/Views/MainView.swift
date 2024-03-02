//
//  ContentView.swift
//  FitnessApp
//
//  Created by eren on 19.02.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                DaysView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
                ChatView(userId: viewModel.currentUserId, userName: viewModel.currentUserName)
                    .tabItem {
                        Label("Chat", systemImage: "message.circle")
                    }
            }
            .accentColor(.red)
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
