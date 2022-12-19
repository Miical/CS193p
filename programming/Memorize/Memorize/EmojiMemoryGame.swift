//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/16.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🏠", "🏡", "🏗️", "🏫", "💒", "🏪", "🏭", "🎡", "🏯", "🛖", "⛲️"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) {
            pairindex in emojis[pairindex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
