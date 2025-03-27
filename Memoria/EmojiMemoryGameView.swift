//
//  ContentView.swift
//  Memoria
//
//  Created by Josue Contreras on 19/03/25.
//

import SwiftUI

 struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        VStack{
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            
            Button("Suffle"){
                viewModel.suffle()
            }
            
            //Spacer()
            //cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        let aspectRatio: CGFloat = 2/3
        return GeometryReader { geometry in
            let gridItemSize = gridItemsWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0){
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio( aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                      
                }
            }
        }
        .frame(height: 650)
        .foregroundColor(.orange)

    }
     
     func gridItemsWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
     ) -> CGFloat {
         let count = CGFloat(count)
         var columnCount = 1.0
         print("cards", count, size.width, size.height, aspectRatio)

         repeat {
             let width = size.width / columnCount
             let heigth = width / aspectRatio
             print("heigth", heigth)

             let rowCount = (count / columnCount).rounded(.up)

             if rowCount * heigth < size.height {
                 return (size.width / columnCount).rounded(.down)//width.rounded(.down)
             }
             columnCount += 1
         } while columnCount < count
         return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack(content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:  2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1: 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        })
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
