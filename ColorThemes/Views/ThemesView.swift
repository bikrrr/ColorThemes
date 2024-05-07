//
//  ThemesView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/25/24.
//

import SwiftUI

struct ThemesView: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 5)

    var body: some View {
        @Bindable var themeManager = themeManager

        NavigationStack {
            Form {
                Section("Theme") {
                    Picker("Select a Theme", selection: $themeManager.selectedTheme) {
                        ForEach(ThemeIdentifier.allCases, id: \.self) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section("Preview") {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(ColorName.allCases, id: \.self) { colorName in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(themeManager.theme.color(for: colorName))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
            .navigationTitle("Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ThemesView()
        .environment(ThemeManager())
}
