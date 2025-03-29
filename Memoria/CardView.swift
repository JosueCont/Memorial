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
        
        struct Pie {
            static let inset: CGFloat = 5
            static let opacity: CGFloat = 0.4
        }
    }
    
    var body: some View {
        Pie(endAngle: .degrees(200))
            .opacity(Constats.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constats.FontSize.largest))
                    .minimumScaleFactor(Constats.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constats.Pie.inset)
            )
            .padding(Constats.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    typealias Card = CardView.Card

    let sampleCard = Card( content: "👻", id: "test")  // Creando una carta de prueba
        return CardView(sampleCard)
}
