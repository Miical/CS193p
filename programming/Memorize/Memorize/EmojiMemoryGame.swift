//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/16.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    init() {
        themeID = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        model = EmojiMemoryGame.createMemoryGame(themeID: themeID)
    }
    
    static func createMemoryGame(themeID: Int) -> MemoryGame<String> {
        let theme = EmojiMemoryGame.themes[themeID]
        let numberOfPairsOfCardToShow = min(theme.numberOfPairsOfCardToShow, theme.emojis.count)
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCardToShow) {
            pairindex in emojis[pairindex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var color: Color {
        switch EmojiMemoryGame.themes[themeID].color {
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "brown":
            return .brown
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        default:
            return .black
        }
    }
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    var themeName: String {
        EmojiMemoryGame.themes[themeID].name
    }
    var themeID: Int
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        themeID = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        model = EmojiMemoryGame.createMemoryGame(themeID: themeID)
    }
    
    // MARK: - Theme
    
    private struct Theme {
        var name: String
        var emojis: [String]
        var numberOfPairsOfCardToShow: Int
        var color: String
    }
    
    private static let themes: [Theme] = [
        Theme(
            name: "Fruits",
            emojis: ["🍏", "🍐", "🍊", "🍉", "🍌", "🍒", "🍑", "🫐", "🍓", "🍇"],
            numberOfPairsOfCardToShow: 7,
            color: "orange"),
        Theme(
            name: "Animals",
            emojis: ["🐶", "🐱", "🐭", "🐰", "🐼", "🐨", "🐯", "🦁", "🐷", "🐵", "🐣", "🐧"],
            numberOfPairsOfCardToShow: 8,
            color: "yellow"),
        Theme(
            name: "Buildings",
            emojis: ["🏠", "🏡", "🏗️", "🏫", "💒", "🏪", "🏭", "🎡", "🏯", "🛖", "⛲️"],
            numberOfPairsOfCardToShow: 6,
            color: "brown"),
        Theme(
            name: "Flowers",
            emojis: ["💐", "🌷", "🥀", "🌹", "🌺", "🌸", "🌼"],
            numberOfPairsOfCardToShow: 7,
            color: "red"),
        Theme(
            name: "Cars",
            emojis: ["🚗", "🚕", "🚙", "🚌", "🚎"],
            numberOfPairsOfCardToShow: 5,
            color: "blue"),
        Theme(
            name: "Pictures",
            emojis: ["🗾", "🎑", "🏞️", "🌅", "🌄"],
            numberOfPairsOfCardToShow: 5,
            color: "green")
    ]
}
