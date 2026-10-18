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
    }

    private var list: some View {
        List(selection: $selectedDeckID) {
            ForEach(decks) { deck in
                Text(deck.title)
            }
        }
        .navigationTitle("Decks")
    }
}
