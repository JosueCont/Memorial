//
//  ContentView.swift
//  Memoria
//
//  Created by Josue Contreras on 19/03/25.
//

import SwiftUI

 struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    let emojis: Array<String> = ["👹", "👻", "💩", "👽", "👹", "👻", "💩", "👽" ]
    //@State var cardCount: Int = 4
    
    
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            
            //Spacer()
            //cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85, maximum: 120))]){
            ForEach(emojis.indices , id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
            
        
        .foregroundColor(.orange)
    }
    
    /*var cardCountAdjusters: some View {
        HStack{
            cardRemover
            cardAdd
        }
        .imageScale(.large)
        .padding(5)
    }*/
    
        /*func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        },label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle")
       
    }
    
    var cardAdd: some View {
         cardCountAdjuster(by: +1, symbol: "plus.circle")
    }*/
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack(content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:  2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1: 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        })
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
