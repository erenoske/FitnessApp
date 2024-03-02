//
//  RemoteImageView.swift
//  FitnessApp
//
//  Created by eren on 24.02.2024.
//

import SwiftUI

struct RemoteImageView: View {
    let path: String
    @State private var image: UIImage?
    @StateObject var viewModel = ChatViewViewModel()

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .onAppear {
                    viewModel.retrievePhoto(path: path) { retrievedImage in
                        self.image = retrievedImage
                    }
                }
        }
    }
}

#Preview {
    RemoteImageView(path: "test")
}
