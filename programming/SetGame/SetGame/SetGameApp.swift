//
//  SetGameApp.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        let game = SetGame()
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
