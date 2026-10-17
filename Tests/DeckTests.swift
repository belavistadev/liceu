//
//  DeckTests.swift
//  Tests
//
//  Created by Thiago Campos on 17/10/26.
//

import Foundation
@testable import Liceu
import SwiftData
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

struct DeckFlashcardRelationshipTests {
    let container: ModelContainer
    let context: ModelContext

    init() throws {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Deck.self, Flashcard.self, configurations: configuration)
        context = ModelContext(container)
    }

    @Test("Assigning a deck to a flashcard adds it to the deck's flashcards")
    func flashcardIsAddedToDeck() throws {
        let deck = Deck(title: "French")
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia")
        context.insert(deck)
        context.insert(flashcard)

        flashcard.deck = deck

        #expect(deck.flashcards?.contains(flashcard) == true)
    }

    @Test("Deleting a deck deletes its flashcards")
    func deletingDeckDeletesFlashcards() throws {
        let deck = Deck(title: "French")
        context.insert(deck)
        context.insert(Flashcard(front: "Bonjour", back: "Bom dia", deck: deck))
        context.insert(Flashcard(front: "Merci", back: "Obrigado", deck: deck))
        try context.save()

        context.delete(deck)
        try context.save()

        #expect(try context.fetchCount(FetchDescriptor<Flashcard>()) == 0)
    }

    @Test("Deleting a flashcard keeps its deck")
    func deletingFlashcardKeepsDeck() throws {
        let deck = Deck(title: "French")
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia", deck: deck)
        context.insert(deck)
        context.insert(flashcard)
        try context.save()

        context.delete(flashcard)
        try context.save()

        #expect(try context.fetchCount(FetchDescriptor<Deck>()) == 1)
        #expect(deck.flashcards?.isEmpty == true)
    }
}
