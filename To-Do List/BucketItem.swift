//
//  To_Do_ListApp.swift
//  To-Do List
//
//  Created by Oguzhan Cirpan on 04.04.25.
//

import Foundation

struct BucketItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var note = ""
    var completedDate = Date.distantPast
    
    static var samples: [BucketItem] {
        [
        BucketItem(name: "Climb Mt. Everest"),
        BucketItem(name: "Visit Hawaii", note: "Go to Maui and Oahu"),
        BucketItem(name: "Get Married", note: "Found the love of my life", completedDate: Date())
        ]
    }
}
