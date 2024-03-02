//
//  ChatMessage.swift
//  FitnessApp
//
//  Created by eren on 22.02.2024.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: String
    let text: String
    let userId: String
    let userName: String
    let imageUrl: String
    let createdTime: TimeInterval
}
