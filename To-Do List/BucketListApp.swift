//
//  To_Do_ListApp.swift
//  To-Do List
//
//  Created by Oguzhan Cirpan on 04.04.25.
//

import SwiftUI

@main
struct BucketListApp: App {
    @StateObject var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environmentObject(dataStore)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
