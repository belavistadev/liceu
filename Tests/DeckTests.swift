//
//  DeckTests.swift
//  Tests
//
//  Created by Thiago Campos on 17/10/26.
//

import Foundation
@testable import Liceu
import Testing

struct DeckTests {
    @Test("Deck only requires a title")
    func createDeckWithMinimumInput() {
        let deck = Deck(title: "French")
        #expect(deck.title == "French")
    }

    @Test("Deck has an optional summary")
    func deckHasSummary() {
        let summary = "Learning french for my upcoming Paris travel"
        let deck = Deck(title: "French", summary: summary)
        #expect(deck.summary == summary)
    }

    @Test("Deck's creation date is registered on init")
    func deckHasCreationDate() {
        let now = Date.now
        let deck = Deck(title: "French", creationDate: now)
        #expect(deck.creationDate == now)
    }

    @Test("Deck's modification date is the same as the creation date")
    func modificationDateMatchesCreationDate() {
        let now = Date.now
        let deck = Deck(title: "French", creationDate: now)
        #expect(deck.modificationDate == now)
        #expect(deck.creationDate == deck.modificationDate)
    }

    @Test("Deck should be able to be archived")
    func deckCanBeArchived() {
        let deck = Deck(title: "French")
        // Deck is not archived by default
        #expect(!deck.isArchived)

        deck.isArchived = true
        #expect(deck.isArchived)
    }
}
