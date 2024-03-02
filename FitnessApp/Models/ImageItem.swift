//
//  ImageItem.swift
//  FitnessApp
//
//  Created by eren on 24.02.2024.
//

import Foundation

struct ImageItem: Codable, Identifiable {
    let id: String
    let url: String
    let userId: String
    let userName: String
    let createdTime: TimeInterval
}
