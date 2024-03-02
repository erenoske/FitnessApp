//
//  ChatItem.swift
//  FitnessApp
//
//  Created by eren on 22.02.2024.
//

import Foundation

struct ChatItem: Codable, Identifiable {
    let id: String
    let userId: String
    let userName: String
    let message: String
    let createdTime: TimeInterval
}
