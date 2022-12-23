//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/16.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(of: theme)
    }
    
    static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        let numberOfPairsOfCardToShow = min(theme.numberOfPairsOfCardToShow, theme.emojis.count)
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCardToShow) {
            pairindex in String(emojis[pairindex])
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var color: Color {
        Color(rgbaColor: theme.color)
    }
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    var themeName: String {
        theme.name
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(of: theme)
    }
    
}
