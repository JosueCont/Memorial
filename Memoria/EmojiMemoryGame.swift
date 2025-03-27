//
//  EmojiMemoryGame.swift
//  Memoria
//
//  Created by Josue Contreras on 21/03/25.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👹", "👻", "💩", "👽", "👹", "👻", "💩", "👽" ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(numberOfPairsOfCards: 12) { parIndex in
            if emojis.indices.contains(parIndex){
                return emojis[parIndex]
            }else{
                return "😀"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    // MARK: - Intents
    func suffle(){
        model.shuffle()
    }
}
