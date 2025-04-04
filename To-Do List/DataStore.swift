//
//  To_Do_ListApp.swift
//  To-Do List
//
//  Created by Oguzhan Cirpan on 04.04.25.
//

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
            fatalError("Konnte die To-Do Lliste nicht kodieren und speichernt.")
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
