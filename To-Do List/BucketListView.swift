//
//  ContentView.swift
//  To-Do List
//
//  Created by Oguzhan Cirpan on 04.04.25.
//


import SwiftUI

struct BucketListView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var newItem = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Bucket Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        let newBucketItem = BucketItem(name: newItem)
                        dataStore.bucketList.append(newBucketItem)
                        newItem = ""
                        dataStore.saveList()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItem.isEmpty)
                }
                .padding()
                List {
                    ForEach($dataStore.bucketList) { $item in
                        NavigationLink(value: item) {
                            TextField(item.name, text: $item.name, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .font(.title3)
                                .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                        }
                        .onChange(of: item) {
                            dataStore.saveList()
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete { indexSet in
                        dataStore.bucketList.remove(atOffsets: indexSet)
                        dataStore.saveList()
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Bucket List")
            .navigationDestination(for: BucketItem.self) { item in
                DetailView(bucketItem: item)
            }
        }
    }
}


struct BucketListView_Preview: PreviewProvider {
    static var previews: some View {
        BucketListView()
            .environmentObject(DataStore())
    }
}
