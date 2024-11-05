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
    let destinationID: DestinationID? // Use an enum to represent different destination types

    init(
        iconName: String,
        text: String,
        color: Color,
        detailText: String? = nil,
        isToggle: Bool = false,
        destinationID: DestinationID? = nil
    ) {
        self.iconName = iconName
        self.text = text
        self.color = color
        self.detailText = detailText
        self.isToggle = isToggle
        self.destinationID = destinationID
    }

    static func == (lhs: Setting, rhs: Setting) -> Bool {
        return lhs.id == rhs.id
    }
}

// Enum representing the various destination views
enum DestinationID: Hashable {
    case bluetooth
    case wifi
    case cellular
    case notifications
    case custom(String) // Allows adding other custom destinations
}

extension Setting {
    static func createSettings(theme: ColorTheme) -> [Setting] {
        return [
            Setting(
                iconName: "airplane",
                text: "Airplane Mode",
                color: theme.color(for: .iOSOrange),
                isToggle: true
            ),
            Setting(
                iconName: "wifi",
                text: "Wi-Fi",
                color: theme.color(for: .iOSBlueDark),
                detailText: "FBISurveillanceVan",
                destinationID: .wifi
            ),
            Setting(
                iconName: "dot.radiowaves.right",
                text: "Bluetooth",
                color: theme.color(for: .iOSBlue),
                detailText: "On",
                destinationID: .bluetooth
            ),
            Setting(
                iconName: "antenna.radiowaves.left.and.right",
                text: "Cellular",
                color: theme.color(for: .iOSGreen),
                destinationID: .cellular
            ),
            Setting(
                iconName: "bell.badge.fill",
                text: "Notifications",
                color: theme.color(for: .iOSRed),
                destinationID: .notifications
            )
        ]
    }
}
