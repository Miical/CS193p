//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/14.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .font(.title)
                .fontWeight(.black)
            Text("Score: \(viewModel.score)")
                .font(.footnote)
                .padding(.bottom)
                
                
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            
            Spacer()
            Text("Start Game")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(.blue)
                .onTapGesture {
                    viewModel.newGame()
                }
        }
        .foregroundColor(viewModel.color)
        .padding(.horizontal)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding(.all)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testTheme = Theme(
            name: "Fruits",
            emojis: "🍏🍐🍊🍉🍌🍒🍑🫐🍓🍇",
            numberOfPairsOfCardToShow: 7,
            color: RGBAColor(color: Color(.red)),
            id: 0)
        let game = EmojiMemoryGame(theme: testTheme)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
