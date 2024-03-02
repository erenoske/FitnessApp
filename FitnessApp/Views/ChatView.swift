//
//  ChatView.swift
//  FitnessApp
//
//  Created by eren on 22.02.2024.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseStorage

struct ChatView: View {
    @StateObject var viewModel = ChatViewViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @StateObject var bugOut = ProfileViewViewModel()
    
    private let userId : String
    private let userName: String
    
    init(userId: String, userName: String) {
        self.userId = userId
        self.userName = userName
    }
    
    var body: some View {
        let textFieldColor = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color.white
        
        NavigationView {
            VStack {
                if selectedImage != nil {
                    VStack {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 10)
                        
                        VStack {
                            Button {
                                viewModel.uploadPhoto(selectedImage: selectedImage)
                                selectedImage = nil
                            } label: {
                                Text("Upload Photo")
                                    .foregroundColor(Color.white)
                                    .padding(.all, 10)
                                    .background(Color.red)
                                    .cornerRadius(5.0)
                                    .padding(.bottom, 10)
                            }
                            Button {
                                selectedImage = nil
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(Color.white)
                                    .padding(.all, 10)
                                    .background(Color.red)
                                    .cornerRadius(5.0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    if viewModel.isMessageDone == true {
                        ScrollViewReader { proxy in
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(viewModel.messages) { message in
                                        if message.userId == userId {
                                            HStack {
                                                Spacer()
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        Text(message.text)
                                                            .font(.body)
                                                             .foregroundStyle(Color.white)
                                                        if message.imageUrl != "" {
                                                            RemoteImageView(path: message.imageUrl)
                                                                 .frame(width: 200, height: 200)
                                                                 .padding(.vertical, 10)
                                                        }
                                                        Text("\(Date(timeIntervalSince1970: message.createdTime).formatted(date: .abbreviated, time: .shortened))")
                                                           .font(.footnote)
                                                           .foregroundStyle(colorScheme == .dark ? Color(.secondaryLabel) : Color.white)
                                                    }
                                                }
                                                .padding(.all, 10)
                                                .background(Color.red)
                                                .cornerRadius(10.0)
                                            }
                                        } else {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    NavigationLink(destination: DaysView(userId: message.userId)) {
                                                        Text(message.userName)
                                                    }
                                                    Text(message.text)
                                                        .font(.body)
                                                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                                                    if message.imageUrl != "" {
                                                        RemoteImageView(path: message.imageUrl)
                                                             .frame(width: 250, height: 250)
                                                    }
                                                    Text("\(Date(timeIntervalSince1970: message.createdTime).formatted(date: .abbreviated, time: .shortened))")
                                                        .font(.footnote)
                                                        .foregroundStyle(Color(.secondaryLabel))

                                                }
                                                .padding(.all, 10)
                                                .background(textFieldColor)
                                                .shadow(color: Color.black.opacity(1), radius: 60, x: 0.0, y: 16)
                                                .cornerRadius(10.0)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            .onChange(of: viewModel.lastMessageId) { oldValue, id in
                                proxy.scrollTo(id, anchor: .bottom)
                            }
                            .onAppear {
                                proxy.scrollTo(viewModel.lastMessageId, anchor: .bottom)
                            }
                        }
                    } else {
                        VStack(alignment: .center) {
                            ProgressView()
                                .scaleEffect(2)
                        }
                    }
                }
                Spacer()
                HStack {
                    TextField("Type Message", text: $viewModel.messageText)
                        .font(.body)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity)
                        .background(textFieldColor)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.3), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom, 10)
                        .onSubmit {
                            viewModel.userName = userName
                            viewModel.save()
                            viewModel.messageText = ""
                        }
                    Button {
                        // Show the image picker
                        
                        isPickerShowing = true
                    } label: {
                        VStack {
                            Image(systemName: "photo.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                        }
                        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                            //Image picker
                            
                            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                        }
                    }
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle("Chat")
            .padding()
        }
    }
}


#Preview {
    ChatView(userId: "hoB1RzmMVtZlPW9XEAj0VWSxr5y1" , userName: "Erenoske")
}
