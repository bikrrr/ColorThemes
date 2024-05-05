//
//  TestView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/25/24.
//

import SwiftUI

public enum ThemeIdentifier: String, CaseIterable, Identifiable {
    case iOSLight = "iOSLight"
    case light = "Light"
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

enum ColorName: String, CaseIterable, Identifiable {
    case iOSBlue,
         iOSBlueDark,
         iOSGray,
         iOSGreen,
         iOSIndigo,
         iOSOrange,
         iOSRed,
         primaryField01,
         primaryField01Active,
         primaryField02,
         primaryField02Active,
         primaryField03,
         primaryField03Active,
         primaryIcon01,
         primaryIcon01Active,
         primaryIcon02,
         primaryIcon02Active,
         primaryIcon02Selected,
         primaryIcon03,
         primaryIcon03Active,
         primaryIcon04,
         primaryIcon05,
         primaryIcon06,
         primaryInteractive01,
         primaryInteractive01Active,
         primaryInteractive01Disabled,
         primaryInteractive01Hover,
         primaryInteractive02,
         primaryInteractive02Active,
         primaryInteractive02Hover,
         primaryInteractive03,
         primaryText01,
         primaryText02,
         primaryText02Selected,
         primaryUi01,
         primaryUi01Active,
         primaryUi02,
         primaryUi02Active,
         primaryUi02Selected,
         primaryUi03,
         primaryUi04,
         primaryUi05,
         primaryUi05Selected,
         primaryUi06,
         secondaryField01,
         secondaryField01Active,
         secondaryIcon01,
         secondaryIcon02,
         secondaryInteractive01,
         secondaryInteractive01Active,
         secondaryInteractive01Hover,
         secondaryText01,
         secondaryText02,
         secondaryUi01,
         secondaryUi02

    public var id: Self { self }
}

@Observable
class ThemeManager {
    var selectedTheme: ThemeIdentifier = .iOSLight

    var theme: ColorTheme {
        UniversalColorTheme(identifier: selectedTheme)
    }
}

extension ThemeManager {
    var settings: [Setting] {
        Setting.createSettings(theme: theme)
    }
}

struct TestView: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 5)

    var body: some View {
        ScrollView {
            Section(header: Text("Theme")) {
                Picker("Select a Theme", selection: Binding(
                    get: { themeManager.selectedTheme },
                    set: { newValue in themeManager.selectedTheme = newValue }
                )) {
                    ForEach(ThemeIdentifier.allCases, id: \.self) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Color Swatches")) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(ColorName.allCases, id: \.self) { colorName in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(themeManager.theme.color(for: colorName))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    TestView()
        .environment(ThemeManager())
}
