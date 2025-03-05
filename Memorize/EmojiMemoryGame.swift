//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by นางสาวพรทิพย์พา ธีระประเวศ on 5/3/2568 BE.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    private static var emojis = ["🎃", "💀", "🕸️", "😈", "🦇", "👻", "😱", "👽"]
    
    @Published private var model = createMemoryGame()
    
    /*
    
    MemoryGame<String> =
    MemoryGame(numberOfPairs: 12) { index in
        /*
        if emojis.indices.contains(index) {
            return emojis[index]
        } else {
            return "⁉️"
        }*/
        return emojis.indices.contains(index) ? emojis[index] : "⁉️"
    }*/
    
    static func createMemoryGame() -> MemoryGame<String> {
        var model = MemoryGame(numberOfPairs: 8) {index in
            emojis.indices.contains(index) ? emojis[index] : "⁉️"
        }
        model.shuffle()
        return model
    }
    
   func restart() {
       model = EmojiMemoryGame.createMemoryGame()
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    
}
