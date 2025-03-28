//
//  CardView.swift
//  Memoria
//
//  Created by Josue Contreras on 27/03/25.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constats {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let smallest: CGFloat = 10
            static let largest: CGFloat = 200
            static let scaleFactor = smallest / largest
        }
    }
    
    var body: some View {
        ZStack(content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constats.lineWidth)
                Circle()
                    .opacity(0.4)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constats.FontSize.largest))
                            .minimumScaleFactor(Constats.FontSize.scaleFactor)
                            .aspectRatio(1, contentMode: .fit)
                    )
                    .padding(Constats.inset)

            }
            .opacity(card.isFaceUp ? 1: 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        })
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    typealias Card = CardView.Card

    let sampleCard = Card( content: "👻", id: "test")  // Creando una carta de prueba
        return CardView(sampleCard)
}
