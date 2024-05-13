//
//  MediaView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/7/24.
//

import SwiftUI

struct MediaView: View {
    var themeManager: ThemeManager
    private let sectionHeaderLeadingPadding: CGFloat = -20 // Constant for padding

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } header: {
                    HStack {
                        Text("Up Next")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.leading, sectionHeaderLeadingPadding)
                }

                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } header: {
                    HStack {
                        Text("Top Shows From Apple Music")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.leading, sectionHeaderLeadingPadding)
                }

                Section {
                    Text("Hello, World!")
                        .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } header: {
                    HStack {
                        Text("Recently Played")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.leading, sectionHeaderLeadingPadding)
                }
            }
            .headerProminence(.increased)
            .listStyle(DefaultListStyle())
            .navigationTitle("Home")
        }
    }
}

#Preview {
    MediaView(themeManager: ThemeManager())
}
