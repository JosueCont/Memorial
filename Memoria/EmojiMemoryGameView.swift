//
//  ContentView.swift
//  Memoria
//
//  Created by Josue Contreras on 19/03/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    
    var body: some View {
        VStack{
            ScrollView{
                cards
                    .foregroundColor(viewModel.color)
                
            }
            
            HStack{
                score
                Spacer()
                btnShuffle
            }
            
            
            //Spacer()
            //cardCountAdjusters
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score:  \(viewModel.score)")
            .animation(nil)
    }
    
    private var btnShuffle: some View {
        Button("Suffle"){
            withAnimation(){
                viewModel.suffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio( aspectRatio, contentMode: .fit)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causeBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)){
                        viewModel.choose(card)
                    }
                }
        }
        .frame(height: 650)

    }
    
    private func scoreChange(causeBy card: Card) -> Int {
        return 0
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
