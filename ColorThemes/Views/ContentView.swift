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
            Form {
                Section("Sample Screens") {
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                    }
                    
                    NavigationLink(destination: MediaView(themeManager: themeManager)) {
                        Text("Media")
                    }
                }
                
                Section("Theme") {
                    ThemePicker()
                    
                    ThemeColors()
                }
                .navigationTitle("Color Themes")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ThemeManager())
}
