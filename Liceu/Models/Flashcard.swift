//
//  Flashcard.swift
//  Liceu
//
//  Created by Thiago Campos on 17/10/2026.
//

import Foundation
import SwiftData

@Model
final class Flashcard {
    var front: String = ""
    var back: String = ""
    var isArchived: Bool = false
    /// Relationship
    var deck: Deck?
    // Metadata
    var creationDate: Date = Date.now
    var modificationDate: Date = Date.now

    init(front: String, back: String, deck: Deck? = nil, creationDate: Date = .now) {
        self.front = front
        self.back = back
        self.deck = deck
        self.creationDate = creationDate
        modificationDate = creationDate
    }
}
