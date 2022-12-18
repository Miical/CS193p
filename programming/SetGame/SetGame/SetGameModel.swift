//
//  SetGameModel.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import Foundation

struct SetGameModel {
    private(set) var cardsOnDeck: [Card]
    private(set) var cardsOnTable: [Card]
    private(set) var selectedCards: [Card]
    

    
    init() {
        selectedCards = []
        cardsOnTable = []
        cardsOnDeck = []
        var cardsCount = 0
        for number in 1...3 {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        cardsOnDeck.append(
                            Card(number: number, shape: shape,
                                 shading: shading, color: color, id: cardsCount))
                        cardsCount += 1
                    }
                }
            }
        }
        cardsOnDeck.shuffle()
        cardsOnTable += cardsOnDeck[0..<GameConstant.initCardsNumber]
        cardsOnDeck[0..<GameConstant.initCardsNumber] = []
    }
    
    
    mutating func choose(card: Card) {
        if (selectedCards.count < 3) {
            if (selectedCards.contains(where: { $0.id == card.id })) {
                selectedCards.removeAll(where: { $0.id == card.id })
            } else {
                selectedCards.append(card)
            }
        } else {
            if isMatched {
                replaceMatchedSet()
                if (cardsOnTable.contains(where: { $0.id == card.id })) {
                    selectedCards.append(card)
                }
            } else {
                selectedCards = [card]
            }
        }
    }
    
    mutating func dealThreeMoreCards() {
        if isMatched {
            replaceMatchedSet()
        } else {
            cardsOnTable += cardsOnDeck[0..<3]
            cardsOnDeck[0..<3] = []
        }
    }
    
    mutating func replaceMatchedSet() {
        for selectedCard in selectedCards {
            cardsOnTable.removeAll(where: { $0.id == selectedCard.id })
        }
        selectedCards = []
        
        if (cardsOnDeck.count >= 3) {
            cardsOnTable += cardsOnDeck[0..<3]
            cardsOnDeck[0..<3] = []
        }
    }
    
    
    struct GameConstant {
        static let initCardsNumber = 12;
    }
    
    
    struct Card: Identifiable {
        let number: Int
        let shape: Shape
        let shading: Shading
        let color: Color
        let id: Int
    }
    
    enum Shading: CaseIterable { case solid, striped, open }
    enum Shape: CaseIterable { case diamond, squiggle, oval }
    enum Color: CaseIterable { case red, green, purple }
    
    var isMatched: Bool {
        if (selectedCards.count != 3) { return false }
        
        var flag: Int = 0
        if (selectedCards[0].number == selectedCards[1].number
            && selectedCards[1].number == selectedCards[2].number)
            { flag = flag | (1 << 0) }
        if (selectedCards[0].number != selectedCards[1].number
            && selectedCards[1].number != selectedCards[2].number
            && selectedCards[0].number != selectedCards[2].number )
            { flag = flag | (1 << 0) }
        
        if (selectedCards[0].shape == selectedCards[1].shape
            && selectedCards[1].shape == selectedCards[2].shape)
            { flag = flag | (1 << 1) }
        if (selectedCards[0].shape != selectedCards[1].shape
            && selectedCards[1].shape != selectedCards[2].shape
            && selectedCards[0].shape != selectedCards[2].shape )
            { flag = flag | (1 << 1) }
        
        if (selectedCards[0].shading == selectedCards[1].shading
            && selectedCards[1].shading == selectedCards[2].shading)
            { flag = flag | (1 << 2) }
        if (selectedCards[0].shading != selectedCards[1].shading
            && selectedCards[1].shading != selectedCards[2].shading
            && selectedCards[0].shading != selectedCards[2].shading )
            { flag = flag | (1 << 2) }

        if (selectedCards[0].color == selectedCards[1].color
            && selectedCards[1].color == selectedCards[2].color)
            { flag = flag | (1 << 3) }
        if (selectedCards[0].color != selectedCards[1].color
            && selectedCards[1].color != selectedCards[2].color
            && selectedCards[0].color != selectedCards[2].color )
            { flag = flag | (1 << 3) }
        
        return flag == (1 << 4) - 1
    }
}

