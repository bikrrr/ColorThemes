//
//  ThemeManager.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/5/24.
//

import SwiftUI

@Observable
class ThemeManager {
    var selectedTheme: ThemeIdentifier = .iOSLight

    var theme: ColorTheme {
        UniversalColorTheme(identifier: selectedTheme)
    }
}

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

extension ThemeManager {
    var settings: [Setting] {
        Setting.createSettings(theme: theme)
    }
}
