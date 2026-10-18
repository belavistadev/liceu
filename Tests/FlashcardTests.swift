//
//  FlashcardTests.swift
//  Liceu
//
//  Created by Thiago Campos on 17/10/2026.
//

import Foundation
@testable import Liceu
import Testing

struct FlashcardTests {
    @Test("Flashcard only requires front and back values")
    func createFlashcardWithMinimumInput() {
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia")
        #expect(flashcard.front == "Bonjour")
        #expect(flashcard.back == "Bom dia")
    }

    @Test("Flashcard's creation date is registered on init")
    func flashcardHasCreationDate() {
        let now = Date.now
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia", creationDate: now)
        #expect(flashcard.creationDate == now)
    }

    @Test("Flashcard's modification date is the same as the creation date")
    func modificationDateMatchesCreationDate() {
        let now = Date.now
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia", creationDate: now)
        #expect(flashcard.modificationDate == now)
        #expect(flashcard.creationDate == flashcard.modificationDate)
    }

    @Test("Flashcard should be able to be archived")
    func flashcardCanBeArchived() {
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia")
        // Flashcard is not archived by default
        #expect(!flashcard.isArchived)

        flashcard.isArchived = true
        #expect(flashcard.isArchived)
    }

    @Test("Flashcard should have a deck associated")
    func flashcardHasDeck() {
        let deck = Deck(title: "French")
        let flashcard = Flashcard(front: "Bonjour", back: "Bom dia", deck: deck)
        #expect(flashcard.deck === deck)
    }
}
