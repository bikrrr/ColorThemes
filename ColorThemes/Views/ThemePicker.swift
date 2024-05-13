//
//  ThemePicker.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/13/24.
//

import SwiftUI

struct ThemePicker: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    var body: some View {
        @Bindable var themeManager = themeManager

            Picker("Select a Theme", selection: $themeManager.selectedTheme) {
                ForEach(ThemeIdentifier.allCases, id: \.self) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
    }
}

#Preview {
    List {
        ThemePicker()
    }
    .environment(ThemeManager())
}
