//
//  ContentView.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/14.
//

import SwiftUI

struct ContentView: View {
    let foods = ["🍏", "🍐", "🍊", "🍉", "🍌", "🍆", "🥦", "🌽", "🍓", "🍇"]
    let animals = ["🐶", "🐱", "🐭", "🐰", "🐼", "🐨", "🐯", "🦁", "🐷", "🐵", "🐣", "🐧"]
    let buildings = ["🏠", "🏡", "🏗️", "🏫", "💒", "🏪", "🏭", "🎡", "🏯", "🛖", "⛲️"]
    @State var emojis: [String]
    
    init() {
        emojis = foods
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack() {
                Spacer()
                VStack {
                    Image(systemName:"carrot").font(.title)
                    Text("Foods").font(.footnote)
                }.onTapGesture {
                    emojis = foods.shuffled()
                }
                Spacer()
                VStack {
                    Image(systemName:"pawprint").font(.title)
                    Text("Animals").font(.footnote)
                }.onTapGesture {
                    emojis = animals.shuffled()
                }
                Spacer()
                VStack {
                    Image(systemName:"building.2").font(.title)
                    Text("Buildings").font(.footnote)
                }.onTapGesture {
                    emojis = buildings.shuffled()
                }
                Spacer()
            }
            .foregroundColor(.blue)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
                    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
