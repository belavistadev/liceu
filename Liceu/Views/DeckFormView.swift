//
//  DeckFormView.swift
//  Liceu
//
//  Created by Thiago Campos on 18/10/2026.
//

import SwiftData
import SwiftUI

struct DeckFormView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var summary = ""

    var body: some View {
        NavigationStack {
            form
        }
    }

    private var form: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Summary", text: $summary, axis: .vertical)
                .lineLimit(3 ... 5)
        }
        .navigationTitle("New Deck")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", role: .confirm) {
                    let deck = Deck(title: title, summary: summary)
                    modelContext.insert(deck)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    DeckFormView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}
