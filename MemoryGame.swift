//
//  MemorizeGame.swift
//  Memoria
//
//  Created by Josue Contreras on 21/03/25.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent ) {
        cards = []
        //add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card( content: content, id: "\(pairIndex+1)a"))
            cards.append(Card( content: content, id: "\(pairIndex+1)b"))

        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{ cards.indices.filter { index in cards[index].isFaceUp }.only }
        set{ cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card){
        if let chooseIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chooseIndex].isFaceUp && !cards[chooseIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chooseIndex].content == cards[potentialMatchIndex].content {
                        cards[chooseIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chooseIndex
                }
                cards[chooseIndex].isFaceUp = true
            }
        }
        
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil //FIXME: bogus!
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
