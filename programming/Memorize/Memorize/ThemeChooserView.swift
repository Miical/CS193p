//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Jason Liu on 2022/12/22.
//

import SwiftUI

struct ThemeChooserView: View {
    @ObservedObject var themeChooser: ThemeChooser
    
    @State private var editMode: EditMode = .inactive
    @State private var themeToEdit: Theme?
    var body: some View {
        NavigationView {
            List{
                ForEach(themeChooser.themes) { theme in
                    NavigationLink {
                        themeChooser.getGame(of: theme)
                    } label: {
                        themeLabel(of: theme)
                    }
                    .gesture(editMode == .active ? TapToEdit(theme: theme) : nil)
                }
                .onDelete { indexSet in
                    themeChooser.removeTheme(indexSet: indexSet)
                }
                .onMove { indexSet, newOffset in
                    themeChooser.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { newThemeButton() }
                ToolbarItem { EditButton() }
            }
            .environment(\.editMode, $editMode)
            .popover(item: $themeToEdit) { theme in
                 ThemeEditor(theme: $themeChooser.themes[theme]) }
        }
    }
    
    func themeLabel(of theme: Theme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Circle().frame(width: 10).foregroundColor(Color(rgbaColor: theme.color))
                HStack {
                    Text(theme.name).font(.title2).padding(1.0)
                    Spacer()
                    Text("(Pairs: \(theme.numberOfPairsOfCardToShow))")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
            }
            Text(theme.emojis)
        }
    }
    
    func newThemeButton() -> some View {
        Button(action: {
            themeChooser.addTheme(name: "New Theme", emojis: "😀☺️", numberOfPairsOfCardToShow: 2, color: RGBAColor(color: Color(.red)))
            themeToEdit = themeChooser.themes.last!
        }) {
            HStack {
                Image(systemName: "plus.circle")
                Text("New Theme")
            }
        }
    }
    
    func TapToEdit(theme: Theme) -> some Gesture {
        TapGesture().onEnded {
            themeToEdit = theme
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        let themeChooser = ThemeChooser()
        ThemeChooserView(themeChooser: themeChooser)
    }
}
