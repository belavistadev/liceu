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
    @State private var isShowingDismissConfirmation = false

    var body: some View {
        NavigationStack {
            form
        }
        .interactiveDismissDisabled(hasChange)
    }

    private func trim(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var hasChange: Bool {
        !trim(title).isEmpty || !trim(summary).isEmpty
    }

    private func save() {
        let deck = Deck(title: trim(title), summary: trim(summary))
        modelContext.insert(deck)
    }

    private var form: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Summary (Optional)", text: $summary, axis: .vertical)
                .lineLimit(3 ... 5)
        }
        .navigationTitle("New Deck")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    if hasChange {
                        isShowingDismissConfirmation = true
                    } else {
                        dismiss()
                    }
                }
                .alert("Discard this Deck?", isPresented: $isShowingDismissConfirmation) {
                    Button("Discard Changes", role: .destructive) { dismiss() }
                    Button("Keep Editing", role: .cancel) {}
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
