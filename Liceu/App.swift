//
//  App.swift
//  Liceu
//
//  Created by Thiago Campos on 17/10/26.
//

import SwiftData
import SwiftUI

@main struct Liceu: App {
    var body: some Scene {
        WindowGroup {
            DeckListView()
        }
        .modelContainer(for: [Deck.self, Flashcard.self])
    }
}
