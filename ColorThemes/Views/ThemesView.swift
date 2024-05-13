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
        NavigationStack {
            List {
                ThemePicker()
                ThemeColors()
            }
            .navigationTitle("Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ThemesView()
        .environment(ThemeManager())
}
