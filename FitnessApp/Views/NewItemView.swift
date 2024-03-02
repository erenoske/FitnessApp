//
//  NewItemView.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import SwiftUI

enum FocusTextNewItem {
   case titleText, kgText, repsText
}

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPressented: Bool
    @FocusState private var focusField : FocusTextNewItem?
    @Environment(\.colorScheme) var colorScheme
    
    var categoryDay: String
    
    init(newItemPressented: Binding<Bool>, categoryDay: String) {
        self._newItemPressented = newItemPressented
        self.categoryDay = categoryDay
    }
    
    var body: some View {
        
        let textFieldColor = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.white
        
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding()
            
                VStack {
                    // Title
                    TextField("Title", text: $viewModel.title)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom, 10)
                        .focused($focusField, equals: .titleText)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .kgText
                        }
                    // Kg
                    TextField("Kg", text: $viewModel.kg)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom, 10)
                        .focused($focusField, equals: .kgText)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField = .repsText
                        }
                    // Reps
                    TextField("Reps", text: $viewModel.reps)
                        .font(.title3)
                        .padding(.all, 12)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom, 10)
                        .focused($focusField, equals: .repsText)
                        .submitLabel(.done)
                        .onSubmit {
                            // Action
                        }
                    // Button
                    Button {
                        if viewModel.canSave {
                            viewModel.save()
                            newItemPressented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    } label: {
                       Text("Save")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.all, 7)
                            .background(Color.red)
                            .cornerRadius(50)
                    }
                }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields")
                )
            }
            .padding()
        }
        .onAppear() {
            viewModel.category = categoryDay
        }
    }
}

#Preview {
    NewItemView(newItemPressented: Binding(get: {
        return true
    }, set: { _ in
    }), categoryDay: "Salı")
}
