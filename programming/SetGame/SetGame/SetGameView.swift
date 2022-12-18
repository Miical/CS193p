//
//  SetGameView.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    
    var body: some View {
        VStack {
            AspectVGrid(
                items: game.cards,
                aspectRatio: 2/3,
                content: { card in
                    CardView(card: card, cardColor: game.getCardColor(card: card))
                        .padding(4)
                        .onTapGesture { game.choose(card: card) }
                })
            Spacer()
            HStack {
                Spacer()
                Text("New Game").onTapGesture { game.newGame() }
                Spacer()
                Text("Deal 3 More Cards").onTapGesture {
                    if (game.canDealCards()) {
                        game.dealThreeMoreCards()
                    }
                }.foregroundColor(
                    (game.canDealCards() ? Color.blue : Color.gray))
                Spacer()
            }
            .padding(.vertical)
            .fontWeight(.black)
            .foregroundColor(.blue)
            
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var card: SetGame.Card
    var cardColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let rect = RoundedRectangle(cornerRadius: min(geometry.size.height, geometry.size.width) * 0.2)
                rect.fill().foregroundColor(cardColor).opacity(0.2)
                rect.strokeBorder(lineWidth: 4).opacity(0.6)
                
                VStack {
                    ForEach(0..<card.number, id: \.self) {_ in
                        singleShape.frame(
                            width: geometry.size.width / 2,
                            height: geometry.size.height / 9
                        )
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
