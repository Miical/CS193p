//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/22.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    var body: some View {
        Form {
            nameSection
            changeNumberOfPairs
            changeColorSection
            addEmojisSection
            removeEmojiSection
        }
        .navigationTitle("Edit \(theme.name)")
    }
    @State private var emojisToAdd = ""
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    var changeNumberOfPairs: some View {
        Section(header: Text("Number of pairs of cards")) {
            Stepper("\(theme.numberOfPairsOfCardToShow)", value: $theme.numberOfPairsOfCardToShow) {_ in
                if (theme.numberOfPairsOfCardToShow < 2) {
                    theme.numberOfPairsOfCardToShow = 2
                } else if (theme.numberOfPairsOfCardToShow >= theme.emojis.count){
                    theme.numberOfPairsOfCardToShow = theme.emojis.count
                }
            }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            theme.emojis = (emojis + theme.emojis)
                .filter { $0.isEmoji }
                .removingDuplicateCharacters
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = theme.emojis.removingDuplicateCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if (theme.emojis.count > theme.numberOfPairsOfCardToShow) {
                                    theme.emojis.removeAll(where: { String($0) == emoji })
                                }
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    var changeColorSection: some View {
        Section(header: Text("Theme Color")) {
            ColorPicker(selection: Binding(
            get: {
                Color(rgbaColor: theme.color)
            },
            set: {
                theme.color = RGBAColor(color: $0)
            })){}
        }
    }

}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(Theme(name: "Test Theme", emojis: "🌉🕍⛪️", numberOfPairsOfCardToShow: 2, color: RGBAColor(color: Color(.red)), id: 0)))
    }
}

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}
extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}
