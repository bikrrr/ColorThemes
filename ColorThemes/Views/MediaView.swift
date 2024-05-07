//
//  MediaView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/7/24.
//

import SwiftUI

struct MediaView: View {
    var themeManager: ThemeManager

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundStyle(themeManager.theme.color(for: .primaryText01))
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
            .background(themeManager.theme.color(for: .primaryUi02Active))
    }
}

#Preview {
    MediaView(themeManager: ThemeManager())
}
