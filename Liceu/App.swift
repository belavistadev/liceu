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
            ContentView()
        }
        .modelContainer(for: [Deck.self])
    }
}
