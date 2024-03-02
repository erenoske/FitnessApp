//
//  ChatViewViewModel.swift
//  FitnessApp
//
//  Created by eren on 22.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ChatViewViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [ChatMessage]()
    @Published var userName = ""
    @Published var lastMessageId = ""
    @Published var isMessageDone = false
    
    init() {
        fetchMessages()
    }
    
    func save() {
        let db = Firestore.firestore()
        
        guard canSave else {
            return
        }
        
        //Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        let newId = UUID().uuidString
        let newItem = ChatItem(
            id: newId,
            userId: uId,
            userName: userName,
            message: messageText,
            createdTime: Date().timeIntervalSince1970
        )
        
        db.collection("chat")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
    
    func fetchMessages() {
        let db = Firestore.firestore()
        db.collection("chat")
        // Order by time
            .order(by: "createdTime", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetchMessages")
                    return
                }
                
                DispatchQueue.main.async {
                    self.messages = documents.map { document in
                        let data = document.data()
                        let id = document.documentID
                        let userId = data["userId"] as? String ?? ""
                        let text = data["message"] as? String ?? ""
                        let userName = data["userName"] as? String ?? ""
                        let imageUrl = data["url"] as? String ?? ""
                        let createdTime = data["createdTime"] as? TimeInterval ?? 0
                        self.isMessageDone = true
                        return ChatMessage(id: id, text: text, userId: userId, userName: userName, imageUrl: imageUrl, createdTime: createdTime)
                    }
                    
                    if let id = self.messages.last?.id {
                        self.lastMessageId = id
                    }
                }
                    
            }
        }
        
    func uploadPhoto(selectedImage: UIImage?) {
        //Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            print("Current user ID not found")
            return
        }
        
        //Make sure that the selected image property isn't nil
        guard let selectedImage = selectedImage else {
            print("Selected image is nil")
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }
        
        // Specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload that data
        fileRef.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("Error uploading image:", error.localizedDescription)
                return
            }
            
            // Image uploaded successfully, now fetch the user name
            let db = Firestore.firestore()
            db.collection("users").document(uId).getDocument { document, error in
                if let document = document, document.exists {
                    if let userName = document.data()?["name"] as? String {
                        // Create new image item with user name
                        let newId = UUID().uuidString
                        let newItem = ImageItem(
                            id: newId,
                            url: path,
                            userId: uId,
                            userName: userName,
                            createdTime: Date().timeIntervalSince1970
                        )
                        
                        // Save image item to Firestore
                        db.collection("chat").document(newId).setData(newItem.asDictionary()) { error in
                            if let error = error {
                                print("Error saving image item:", error.localizedDescription)
                            } else {
                                print("Image item saved successfully")
                            }
                        }
                    } else {
                        print("User name not found in document")
                    }
                } else {
                    print("User document not found")
                    if let error = error {
                        print("Error fetching user document:", error.localizedDescription)
                    }
                }
            }
        }
    }

    
    func retrievePhoto(path: String, completion: @escaping (UIImage?) -> Void) {
        // Get a reference to storage
        let storageRef = Storage.storage().reference()
        
        // Specify the path
        let fileRef = storageRef.child(path)
        
        // Retrieve the data
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error retrieving photo:", error.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }

}

