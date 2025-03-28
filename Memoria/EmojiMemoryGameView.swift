//
//  ContentView.swift
//  Memoria
//
//  Created by Josue Contreras on 19/03/25.
//

import SwiftUI

 struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
     private let aspectRatio: CGFloat = 2/3
     private let spacing: CGFloat = 4

    
    var body: some View {
        VStack{
            ScrollView{
                cards
                    .foregroundColor(viewModel.color)
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
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio( aspectRatio, contentMode: .fit)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .frame(height: 650)

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


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
