//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/16.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🏠", "🏡", "🏗️", "🏫", "💒", "🏪", "🏭", "🎡", "🏯", "🛖", "⛲️"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) {
            pairindex in emojis[pairindex]
        }
    }
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
}
