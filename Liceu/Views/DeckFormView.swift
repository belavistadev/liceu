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

    private func trim(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func save() {
        let deck = Deck(title: trim(title), summary: trim(summary))
        modelContext.insert(deck)
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
                    save()
                    dismiss()
                }
                .disabled(trim(title).isEmpty)
            }
        }
    }
}

#Preview {
    DeckFormView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}
