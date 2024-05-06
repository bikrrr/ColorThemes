//
//  TestView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/25/24.
//

import SwiftUI

struct TestView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var themeManager: ThemeManager

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 5)

    var body: some View {
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
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    TestView(themeManager: ThemeManager())
}
