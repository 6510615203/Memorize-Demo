//
//  MemoryGame.swift
//  Memorize
//
//  Created by นางสาวพรทิพย์พา ธีระประเวศ on 5/3/2568 BE.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    
    init(numberOfPairs: Int, contentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            cards.append(Card(id: "\(pairIndex)a", content: contentFactory(pairIndex)))
            cards.append(Card(id: "\(pairIndex)b", content: contentFactory(pairIndex)))
        }
        
    }
    
    var indexOfTheOnlyOneFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOnlyOneFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    indexOfTheOnlyOneFaceUpCard = nil
                } else {
                    indexOfTheOnlyOneFaceUpCard = chosenIndex
                    
                    for index in cards.indices {
                        cards[index].isFaceUp = false
                    }
                }
                cards[chosenIndex].isFaceUp = true
            }
            
            
        }
        
    }
    
    func index(of card: Card) -> Int? {
        for index  in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable, Equatable {
        let id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
 /*
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.id == rhs.id
        }*/
    }
}
