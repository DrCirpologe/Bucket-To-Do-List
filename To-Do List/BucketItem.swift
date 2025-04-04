//
// Created for BucketList
// by  Stewart Lynch on 2023-01-21
// Using Swift 5.0
// Running on macOS 13.1
// 
// Folllow me on Mastodon: @StewartLynch@iosdev.space
// Or, Twitter, if it still exits: https://twitter.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

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
