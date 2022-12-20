//
//  SetGame.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import SwiftUI

class SetGame: ObservableObject {
    typealias Card = SetGameModel.Card
    @Published private var model = SetGameModel()
    
    var cards: [Card] { model.cardsOnTable }
    var deckCards: [Card] { model.cardsOnDeck }
    var discardedCards: [Card] { model.discardedCards}
    
    func getCardColor(card: Card) -> Color {
        if (model.selectedCards.count < 3) {
            if (model.selectedCards.contains(where: { $0.id == card.id })) {
                return .blue
            }
        } else {
            if (model.selectedCards.contains(where: { $0.id == card.id })) {
                if (model.isMatched) { return .green }
                else { return .red }
            }
        }
        return .white
    }
    
    func canDealCards() -> Bool {
        return model.cardsOnDeck.count >= 3
    }
    
    // MARK: Intent
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = SetGameModel()
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
}

