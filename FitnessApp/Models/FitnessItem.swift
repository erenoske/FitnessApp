//
//  FitnessItem.swift
//  FitnessApp
//
//  Created by eren on 20.02.2024.
//

import Foundation

struct FitnessItem: Codable, Identifiable {
    let id: String
    let title: String
    let kg: String
    let reps: String
    let category: String
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
