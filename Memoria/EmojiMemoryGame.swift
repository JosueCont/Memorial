//
//  EmojiMemoryGame.swift
//  Memoria
//
//  Created by Josue Contreras on 21/03/25.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["👹", "👻", "💩", "👽", "👹", "👻", "💩", "👽" ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(numberOfPairsOfCards: 2) { parIndex in
            if emojis.indices.contains(parIndex){
                return emojis[parIndex]
            }else{
                return "😀"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var color : Color{
        .orange
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    // MARK: - Intents
    func suffle(){
        model.shuffle()
    }
}
