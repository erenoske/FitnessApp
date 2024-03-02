//
//  FitnessItemsView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI
import FirebaseFirestoreSwift

struct FitnessView: View {
    @StateObject var viewModel = FitnessViewViewModel()
    @StateObject var fitnessItemViewModel = FitnessItemViewViewModel()
    @FirestoreQuery var items: [FitnessItem]
    @State private var showAlert = false
    
    private let userId: String
    let categoryDay: String
    
    init(userId: String, categoryDay: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self.categoryDay = categoryDay
    }

    var body: some View {
        var filteredItems: [FitnessItem] {
            return items.filter{ $0.category == categoryDay}
        }
            VStack {
                List(filteredItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.title)
                                        .font(.body)
                                    Text(item.kg + " Kg")
                                        .font(.body)
                                    Text(item.reps + " Reps")
                                        .font(.body)
                                }
                                // Format date
                                 Text("\(Date(timeIntervalSince1970: item.createdDate).formatted(date: .abbreviated, time: .shortened))")
                                    .font(.footnote)
                                   .foregroundStyle(Color(.secondaryLabel))
                            }
                            Spacer()
                            Button {
                                fitnessItemViewModel.togleIsDone(item: item)
                            } label: {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(Color.red)
                            }
                        }
                            .swipeActions {
                                Button {
                                    // Delete
                                    viewModel.delete(id: item.id)
                                } label: {
                                    Image(systemName: "trash.circle")
                                }
                                .tint(.red)
                        }
                    
                }
                .listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }
            .navigationTitle("List \(categoryDay)")
            .toolbar {
                Button {
                    // Action
                    showAlert = true
                } label: {
                    Text("Clean All")
                        .foregroundStyle(Color.red)
                }
                .alert(isPresented: $showAlert) {
                    // Onay mesajı
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("Do you want to proceed?"),
                        primaryButton: .default(Text("Yes")) {
                            // Action
                            viewModel.resetAllDoneStatus()
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                Spacer()
                Button {
                    // Action
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.red)
                }
                
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPressented: $viewModel.showingNewItemView, categoryDay: categoryDay)
            }
        }
    }

#Preview {
    FitnessView(userId: "uF5gXCx86VSFyLOYRVtFc3j1dE02", categoryDay: "Salı")
}
