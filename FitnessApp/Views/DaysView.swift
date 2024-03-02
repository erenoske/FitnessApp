//
//  DaysView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI


struct DaysView: View {
    @StateObject var viewModel = MainViewViewModel()
    @StateObject var currentModel = MainViewViewModel()
    static let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    private let userId : String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        if currentModel.currentUserId == userId {
            NavigationView {
                List(DaysView.days, id: \.self) { day in
                    NavigationLink(destination: FitnessView(
                        userId: userId,
                        categoryDay: day
                        )) {
                        Text(day)
                                .font(.title3)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Days")
            }
            .accentColor(.red)
        } else {
            List(DaysView.days, id: \.self) { day in
                NavigationLink(destination: FitnessView(
                    userId: userId,
                    categoryDay: day
                    )) {
                    Text(day)
                            .font(.title3)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Days")
        }

    }
}

#Preview {
    DaysView(userId: "uF5gXCx86VSFyLOYRVtFc3j1dE02")
}
