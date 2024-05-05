//
//  ContentView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(ThemeManager.self) var themeManager
    @State private var searchText = ""

    private var settings: [Setting] {
        Setting.createSettings(theme: themeManager.theme)
    }

    var body: some View {
        NavigationStack {
            List {
                ProfileView()

                Section {
                    ForEach(settings.prefix(6), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }

                Section {
                    ForEach(settings.suffix(4), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Text("Theme:")
                        Picker("Theme", selection: Binding(
                            get: { themeManager.selectedTheme },
                            set: { newValue in
                                themeManager.selectedTheme = newValue
                            }
                        )) {
                            ForEach(ThemeIdentifier.allCases, id: \.self) { theme in
                                Text(theme.rawValue).tag(theme)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal, -4)
        }
        .searchable(text: $searchText)
    }
}

struct ProfileView: View {
    @Environment(ThemeManager.self) var themeManager

    var body: some View {
        Section(header: Spacer().frame(height: 0)) {
            NavigationLink(destination: Text("Destination for Pat Smith")) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text("Pat Smith")
                            .font(.title2)
                        Text("Apple ID, iCloud, Media & Purchases")
                            .font(.custom(
                                "SF Pro",
                                size: 14,
                                relativeTo: .subheadline))
                            .fontWeight(.ultraLight)
                            .foregroundStyle(.primary)
                    }
                }
            }

            NavigationLink(destination: Text("Destination for Family")) {
                HStack {
                    HStack(spacing: -10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                            .frame(width: 35, height: 30)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                            .frame(width: 35, height: 30)
                    }
                    VStack(alignment: .leading) {
                        Text("Family")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

struct SettingCell: View {
    let setting: Setting
    @State private var isOn: Bool = false

    var body: some View {
        if setting.isToggle {
            Toggle(isOn: $isOn) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
        } else {
            NavigationLink(destination: Text("Destination for \(setting.text)")) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
        }
    }

    @ViewBuilder
    private var settingIcon: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(setting.color)
            .frame(width: 30, height: 30)
            .overlay(
                Image(systemName: setting.iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            )

        Text(setting.text)

        Spacer()

        if let detailText = setting.detailText {
            Text(detailText)
                .foregroundStyle(.primary)
                .fontWeight(.light)
        }
    }
}

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

#Preview {
    ContentView()
        .environment(ThemeManager())
}
