//
//  SetGameView.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()
    private func deal(_ card: SetGame.Card) {
        dealt.insert(card.id)
    }
    private func isUndealt(_ card: SetGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    
    var body: some View {
        VStack {
            gameBody
            Spacer()
            
            HStack {
                Spacer()
                discardBody
                deckBody
            }.frame(height: 100)
                .padding(.all)
            newGame
            .padding(.all)
            .fontWeight(.black)
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
    
    var gameBody: some View {
      AspectVGrid(
            items: game.cards,
            aspectRatio: 2/3,
            content: { card in
                if (isUndealt(card)) {
                    Color.clear
                } else {
                    CardView(card: card, cardColor: game.getCardColor(card: card))
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                game.choose(card: card)
                            }
                        }
                }
            })
    }
    
    var newGame: some View {
        Button("New Game") {
            withAnimation {
                dealt.removeAll()
                game.newGame()
            }
            game.cards.forEach({ card in
                withAnimation(dealAnimation(for: card)) { deal(card) }
            })
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach((game.deckCards + game.cards).filter({isUndealt($0)})) { card in
                CardView(card: card, cardColor: game.getCardColor(card: card), isFaceDown: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(-Double(getZIndex(card: card)))
                    .onAppear {
                        withAnimation(dealAnimation(for: card)) {
                            if (game.cards.contains(where: { $0.id == card.id })) {
                                deal(card)
                            }
                        }
                    }
            }.aspectRatio(2/3, contentMode: .fit)
        }.onTapGesture {
            if (game.canDealCards()) {
                withAnimation {
                    game.deckCards[0..<3].forEach({deal($0)})
                    game.dealThreeMoreCards()
                }
            }
        }
    }
    
    private func dealAnimation(for card: SetGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration
                                     / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    func getZIndex(card: SetGame.Card) -> Int {
        if let index = game.cards.firstIndex(
            where: { $0.id == card.id }) {
            return index
        } else {
            return game.cards.count +
                game.deckCards.firstIndex(where: { $0.id == card.id })!
        }
    }
    
    var discardBody: some View {
        ZStack {
            ForEach(game.discardedCards) { card in
                CardView(card: card, cardColor: game.getCardColor(card: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }.aspectRatio(2/3, contentMode: .fit)
        }
    }
    
    private struct CardConstants {
        static var totalDealDuration: Double = 2
        static var dealDuration: Double = 0.2
        
    }
    
}

struct CardView: View {
    var card: SetGame.Card
    var cardColor: Color
    var isFaceDown: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let rect = RoundedRectangle(cornerRadius: min(geometry.size.height, geometry.size.width) * 0.2)
                if isFaceDown {
                    rect.fill().foregroundColor(.blue)
                } else {
                    rect.fill().foregroundColor(cardColor).opacity(cardColor == .white ? 1 : 0.2)
                    rect.strokeBorder(lineWidth: 2).foregroundColor(.blue)
                        
                    VStack {
                        ForEach(0..<card.number, id: \.self) {_ in
                            singleShape.frame(
                                width: geometry.size.width / 2,
                                height: geometry.size.height / 9
                            )
                        }
                    }
                }
            }
        }.foregroundColor(color)
    }
    
    var singleShape: some View{
        ZStack {
            switch card.shape {
            case .squiggle:
                Rectangle().opacity(opacity)
            case .oval:
                Ellipse().opacity(opacity)
            case .diamond:
                Diamond().opacity(opacity)
            }
            
            switch card.shape {
            case .squiggle:
                Rectangle().stroke(lineWidth: 3)
            case .oval:
                Ellipse().stroke(lineWidth: 3)
            case .diamond:
                Diamond().stroke(lineWidth: 3)
            }
        }
    }
    
    var color: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }
    
    var opacity: Double {
        switch card.shading {
        case .solid:
            return 1.0
        case .striped:
            return 0.4
        case .open:
            return 0
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        SetGameView(game: game)
            .preferredColorScheme(.light)
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
