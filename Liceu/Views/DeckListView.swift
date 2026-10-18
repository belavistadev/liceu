//
//  DeckListView.swift
//  Liceu
//
//  Created by Thiago Campos on 18/10/2026.
//

import SwiftData
import SwiftUI

struct DeckListView: View {
    @Query(sort: \Deck.creationDate, order: .reverse) private var decks: [Deck]
    @State private var selectedDeckID: Deck.ID?
    @State private var isShowingForm: Bool = false

    /// Resolves the selected ID to its live model.
    private var selectedDeck: Deck? {
        decks.first { $0.id == selectedDeckID }
    }

    var body: some View {
        NavigationSplitView {
            list
        } detail: {
            if let selectedDeck {
                Text(selectedDeck.title)
            } else {
                ContentUnavailableView("Select a Deck", systemImage: "rectangle.stack")
            }
        }
        .sheet(isPresented: $isShowingForm) {
            DeckFormView()
        }
    }

    private var list: some View {
        List(selection: $selectedDeckID) {
            ForEach(decks) { deck in
                Text(deck.title)
            }
        }
        .navigationTitle("Decks")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("New Deck", systemImage: "rectangle.stack.badge.plus") {
                    isShowingForm.toggle()
                }
            }
        }
    }
}

#Preview {
    DeckListView()
        .modelContainer(for: [Deck.self, Flashcard.self], inMemory: true)
}
