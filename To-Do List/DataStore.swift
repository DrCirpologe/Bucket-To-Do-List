//
// Created for BucketList
// by  Stewart Lynch on 2023-01-22
// Using Swift 5.0
// Running on macOS 13.1
// 
// Folllow me on Mastodon: @StewartLynch@iosdev.space
// Or, Twitter, if it still exits: https://twitter.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation

class DataStore: ObservableObject {
    @Published var bucketList:[BucketItem] = []
    let fileURL = URL.documentsDirectory.appending(path: "bucketList.json")
    
    init() {
        loadItems()
    }
    
    func loadItems() {
//        bucketList = BucketItem.samples
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                bucketList = try JSONDecoder().decode([BucketItem].self, from: data)
            } catch {
                // The file is corrupt so currently the bucketList is empty so store it and replace the damaged file
                saveList()
            }
        }
    }
    
    func update(bucketItem: BucketItem, note: String, completedDate: Date) {
        if let index = bucketList.firstIndex(where: {$0.id == bucketItem.id}) {
            bucketList[index].note = note
            bucketList[index].completedDate = completedDate
            saveList()
        }
    }
    
    func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(bucketList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not encode bucket list and save it.")
        }
    }
    
    func create(_ newItem: String) {
        let newBucketItem = BucketItem(name: newItem)
        bucketList.append(newBucketItem)
        saveList()
    }
    
    func delete(indexSet: IndexSet) {
        bucketList.remove(atOffsets: indexSet)
        saveList()
    }
}
