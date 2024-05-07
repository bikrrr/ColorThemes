//
//  ContentView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    var body: some View {
        NavigationStack {
            List {
                Section("Preview") {
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings Screen")
                    }

                    NavigationLink(destination: MediaView(themeManager: themeManager)) {
                        Text("Media App")
                    }
                }
            }
            .navigationTitle("Color Themes")
        }
    }
}

#Preview {
    ContentView()
        .environment(ThemeManager())
}
