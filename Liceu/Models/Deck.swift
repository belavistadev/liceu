//
//  Deck.swift
//  Liceu
//
//  Created by Thiago Campos on 17/10/26.
//

import Foundation
import SwiftData

@Model
final class Deck {
    var title: String = ""
    var summary: String?
    var isArchived: Bool = false
    /// Relationship
    @Relationship(deleteRule: .cascade, inverse: \Flashcard.deck)
    var flashcards: [Flashcard]? = []
    // Metadata
    var creationDate: Date = Date.now
    var modificationDate: Date = Date.now

    init(title: String, summary: String? = nil, creationDate: Date = .now) {
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        modificationDate = creationDate
    }
}
