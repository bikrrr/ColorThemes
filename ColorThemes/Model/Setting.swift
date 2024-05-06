//
//  Setting.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/5/24.
//

import SwiftUI

struct Setting: Identifiable, Equatable, Hashable {
    let id = UUID()
    let iconName: String
    let text: String
    let color: Color
    let detailText: String?
    let isToggle: Bool

    init(iconName: String, text: String, color: Color, detailText: String? = nil, isToggle: Bool = false) {
        self.iconName = iconName
        self.text = text
        self.color = color
        self.detailText = detailText
        self.isToggle = isToggle
    }

    static func == (lhs: Setting, rhs: Setting) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Setting {
    static func createSettings(theme: ColorTheme) -> [Setting] {
        return [
            Setting(
                iconName: "airplane",
                text: "Airplane Mode",
                color: theme.color(for: .iOSOrange),
                detailText: nil,
                isToggle: true
            ),
            Setting(
                iconName: "wifi",
                text: "Wi-Fi",
                color: theme.color(for: .iOSBlueDark),
                detailText: "FBISurveillanceVan",
                isToggle: false
            ),
            Setting(
                iconName: "dot.radiowaves.right",
                text: "Bluetooth",
                color: theme.color(for: .iOSBlue),
                detailText: "On",
                isToggle: false
            ),
            Setting(
                iconName: "antenna.radiowaves.left.and.right",
                text: "Cellular",
                color: theme.color(for: .iOSGreen),
                detailText: nil,
                isToggle: false
            ),
            Setting(
                iconName: "personalhotspot",
                text: "Personal Hotspot",
                color: theme.color(for: .iOSGreen),
                detailText: "Off",
                isToggle: false
            ),
            Setting(
                iconName: "network",
                text: "VPN",
                color: theme.color(for: .iOSBlueDark),
                detailText: nil,
                isToggle: true
            ),
            Setting(
                iconName: "bell.badge.fill",
                text: "Notifications",
                color: theme.color(for: .iOSRed),
                detailText: nil,
                isToggle: false
            ),
            Setting(
                iconName: "speaker.wave.3.fill",
                text: "Sounds & Haptics",
                color: theme.color(for: .iOSRed),
                detailText: nil,
                isToggle: false
            ),
            Setting(
                iconName: "moon.fill",
                text: "Focus",
                color: theme.color(for: .iOSIndigo),
                detailText: nil,
                isToggle: false
            ),
            Setting(
                iconName: "hourglass",
                text: "Screen Time",
                color: theme.color(for: .iOSIndigo),
                detailText: nil,
                isToggle: false
            )
        ]
    }
}
