//
//  TestView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/25/24.
//

import SwiftUI

public enum ThemeIdentifier: String, CaseIterable, Identifiable {
    case indigo = "Indigo"
    case rose = "Rosé"

    public var id: Self { self }
}

protocol ColorTheme {
    var identifier: ThemeIdentifier { get }
    func color(for name: ColorName) -> Color
}

struct UniversalColorTheme: ColorTheme {
    var identifier: ThemeIdentifier

    func color(for name: ColorName) -> Color {
        Color("\(identifier.rawValue)/\(name.rawValue)")
    }
}

enum ColorName: String {
    case primaryIcon01,
         primaryIcon01Active,
         primaryIcon02,
         primaryIcon02Active,
         primaryIcon02Selected,
         primaryUi01,
         primaryUi01Active,
         primaryUi02,
         primaryUi02Active,
         primaryUi02Selected,
         primaryUi03,
         primaryUi04,
         primaryUi05,
         primaryUi05Selected,
         primaryUi06
}

struct TestView: View {
    @State private var selectedTheme: ThemeIdentifier = .indigo

    private var theme: ColorTheme {
        UniversalColorTheme(identifier: selectedTheme)
    }

    var body: some View {
        VStack {
            Section("Page Theme") {
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(ThemeIdentifier.allCases, id: \.self) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            VStack {
                Rectangle()
                    .fill(theme.color(for: .primaryIcon02Selected))
                    .frame(height: 100)

                Rectangle()
                    .fill(theme.color(for: .primaryUi05Selected))
                    .frame(height: 100)

                Rectangle()
                    .fill(Color.red)
                    .frame(height: 100)
            }
        }
    }
}

#Preview {
    TestView()
}
