//
//  MemoriaApp.swift
//  Memoria
//
//  Created by Josue Contreras on 19/03/25.
//

import SwiftUI

@main
struct MemoriaApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
