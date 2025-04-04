//
//  To_Do_ListApp.swift
//  To-Do List
//
//  Created by Oguzhan Cirpan on 04.04.25.
//


import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataStore: DataStore
    let bucketItem: BucketItem
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form {
            TextField("Notize", text: $note, axis: .vertical)
            if completedDate != Date.distantPast {
                DatePicker("Abgeschlossen am", selection: $completedDate, displayedComponents: .date)
            }
            Button(completedDate == Date.distantPast ? "Datum hinzufügen" : "Datum löschen") {
                if completedDate == Date.distantPast {
                    completedDate = Date()
                } else {
                    completedDate = Date.distantPast
                }
            }
            .buttonStyle(.borderedProminent)
        }
            .onAppear {
                note = bucketItem.note
                completedDate = bucketItem.completedDate
            }
            .toolbar {
                ToolbarItem {
                    Button("Aktualisieren") {
                        dataStore.update(bucketItem: bucketItem, note: note, completedDate: completedDate)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle(bucketItem.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let bucketItem = BucketItem.samples[2]
    static let bucketList: Binding<[BucketItem]> = .constant(BucketItem.samples)
    static var previews: some View {
        NavigationStack{
            DetailView(bucketItem: bucketItem)
                .environmentObject(DataStore())
        }
    }
}
