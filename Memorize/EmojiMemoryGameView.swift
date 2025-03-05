//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by นางสาวพรทิพย์พา ธีระประเวศ on 19/2/2568 BE.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            
            HStack {
                
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
                
                Button("New Game") {
                    viewModel.restart()
                }
            }
            
        }
        .padding()
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) {
                card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .padding(2)
        }
        .foregroundColor(.blue)
        
    }
   
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white).strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 1000))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            }
        
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

