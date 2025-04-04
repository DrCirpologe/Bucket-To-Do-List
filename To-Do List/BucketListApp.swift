//
//  To_Do_ListApp.swift
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
                        dataStore.create(newItem)
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItem.isEmpty)
                }
                .padding()
                if !dataStore.bucketList.isEmpty {
                    List {
                        ForEach($dataStore.bucketList) { $item in
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                            }
                            .listRowSeparator(.hidden)
                            .onChange(of: item) { _ in
                                dataStore.saveList()
                            }
                        }
                        .onDelete { indexSet in
                            dataStore.delete(indexSet: indexSet)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("Add your first BucketList item.")
                    Image("bucketList")
                    Spacer()
                }
            }
            .navigationTitle("Bucket List")
            .navigationDestination(for: BucketItem.self) { item in
                DetailView(bucketItem: item)
            }
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
            .environmentObject(DataStore())
    }
}
