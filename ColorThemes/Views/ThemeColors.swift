//
//  ThemeColors.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/13/24.
//

import SwiftUI

struct ThemeColors: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 5)

    var body: some View {
        @Bindable var themeManager = themeManager

        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(ColorName.allCases, id: \.self) { colorName in
                RoundedRectangle(cornerRadius: 16)
                    .fill(themeManager.theme.color(for: colorName))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

#Preview {
    List {
        ThemeColors()
    }
    .environment(ThemeManager())
}
