//
//  Cardify.swift
//  Memoria
//
//  Created by Josue Contreras on 29/03/25.
//

import SwiftUI


struct Cardify: ViewModifier, Animatable {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack(content: {
            let base = RoundedRectangle(cornerRadius: 12)
            
            base.strokeBorder(lineWidth: Constats.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1: 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        })
        .rotation3DEffect(
            .degrees(rotation), axis: (0,1,0)
        )
    }
    
    private struct Constats {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
         modifier(Cardify(isFaceUp: isFaceUp))
    }
}
