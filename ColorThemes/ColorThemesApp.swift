//
//  ColorThemesApp.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/23/24.
//

import SwiftUI

@main
struct ColorThemesApp: App {
    @State private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(themeManager)
        }
    }
}
