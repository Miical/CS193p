//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/22.
//

import SwiftUI

struct Theme: Identifiable, Hashable, Codable {
    var name: String
    var emojis: String
    var numberOfPairsOfCardToShow: Int
    var color: RGBAColor
    var id: Int
}

class ThemeChooser: ObservableObject {
    
    @Published var themes: [Theme] = [] {
        didSet {
            scheduleAutosave()
            for theme in themes {
                game[theme.id] = EmojiMemoryGame(theme: theme)
            }
        }
    }
    private var game: [Int : EmojiMemoryGame] = [:]
    
    private var autosaveTimer: Timer?
    
    private func scheduleAutosave() {
        autosaveTimer?.invalidate()
        autosaveTimer = Timer.scheduledTimer(withTimeInterval: Autosave.coalescingInterval, repeats: false) { _ in
            self.autosave()
        }
    }
    
    private struct Autosave {
        static let filename = "Autosaved.themes"
        static var url: URL? {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return documentDirectory?.appendingPathComponent(filename)
        }
        static let coalescingInterval = 5.0
    }
    
    private func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    private func save(to url: URL) {
        let thisfunction = "\(String(describing: self)).\(#function)"
        do {
            let data: Data = try JSONEncoder().encode(themes)
            print("\(thisfunction) json = \(String(data: data, encoding: .utf8) ?? "nil")")
            try data.write(to: url)
            print("\(thisfunction) success!")
        } catch let encodingError where encodingError is EncodingError {
            print("\(thisfunction) couldn't encode themes as JSON because \(encodingError.localizedDescription)")
        } catch {
            print("\(thisfunction) error = \(error)")
        }
    }
    
    private func restore(from url: URL) {
        let json = try? Data(contentsOf: url)
        if let json {
            if let data = try? JSONDecoder().decode([Theme].self, from: json) {
                themes = data
            }
        }
    }
    
    
    init() {
        if let url = Autosave.url {
            restore(from: url)
        }
        if themes.isEmpty {
            addTheme(
                name: "Fruits",
                emojis: "🍏🍐🍊🍉🍌🍒🍑🫐🍓🍇",
                numberOfPairsOfCardToShow: 7,
                color: RGBAColor(color: Color(.red)))
            addTheme(
                name: "Animals",
                emojis: "🐶🐱🐭🐰🐼🐨🐯🦁🐷🐵🐣🐧",
                numberOfPairsOfCardToShow: 8,
                color: RGBAColor(color: Color(.yellow)))
            addTheme(
                name: "Buildings",
                emojis: "🏠🏡🏗️🏫💒🏪🏭🎡🏯🛖⛲️",
                numberOfPairsOfCardToShow: 6,
                color: RGBAColor(color: Color(.brown)))
            addTheme(
                name: "Flowers",
                emojis: "💐🌷🥀🌹🌺🌸🌼",
                numberOfPairsOfCardToShow: 7,
                color: RGBAColor(color: Color(.red)))
            addTheme(
                name: "Cars",
                emojis: "🚗🚕🚙🚌🚎",
                numberOfPairsOfCardToShow: 5,
                color: RGBAColor(color: Color(.blue)))
            addTheme(
                name: "Pictures",
                emojis: "🗾🎑🏞️🌅🌄",
                numberOfPairsOfCardToShow: 5,
                color: RGBAColor(color: Color(.green)))
        }
        game = [:]
        for theme in themes {
            game[theme.id] = EmojiMemoryGame(theme: theme)
        }
    }
    
    func getGame(of theme: Theme) -> some View {
        return EmojiMemoryGameView(viewModel: game[theme.id]!)
    }
    
    // MARK: - Intent
    
    func addTheme(name: String, emojis: String,
                  numberOfPairsOfCardToShow: Int, color: RGBAColor) {
        themes.append(
            Theme(name: name, emojis: emojis,
                  numberOfPairsOfCardToShow: numberOfPairsOfCardToShow,
                  color: color, id: themes.count))
        game[themes.last!.id] = EmojiMemoryGame(theme: themes.last!)
    }
    
    func removeTheme(indexSet: IndexSet) {
        for index in indexSet {
            game.removeValue(forKey: themes[index].id)
        }
        themes.remove(atOffsets: indexSet)
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
