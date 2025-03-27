//
//  MemorizeGame.swift
//  Memoria
//
//  Created by Josue Contreras on 21/03/25.
//

import Foundation


struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card){
        
    }
    
    struct Card{
        var isFaceUp: Bool
        var isMatched: Bool
        var Content: CardContent
    }
    
}
