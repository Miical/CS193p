//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/14.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
